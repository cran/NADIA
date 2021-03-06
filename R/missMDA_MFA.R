#' Perform imputation using MFA algorithm.
#'
#' @description Function use MFA (Multiple Factor Analysis) to impute missing data.
#' @details  Groups are created using the original column order and taking as much variable to one group as possible. MFA requires selecting group type but numeric types can only be set as 'c' - centered and 's' - scale to unit variance.
#' It's impossible to provide these conditions so numeric type is always set as 's'.  Because of that imputation can depend from column order. In this function, no param is set automatically but if selected ncp don't work function will try use ncp=1.
#'
#'
#' @param df data.frame. Df to impute with column names and without target column.
#' @param col_type character vector. Vector containing column type names.
#' @param percent_of_missing numeric vector. Vector contatining percent of missing data in columns for example  c(0,1,0,0,11.3,..)
#' @param col_0_1 Decaid if add bonus column informing where imputation been done. 0 - value was in dataset, 1 - value was imputed. Default False. (Works only for returning one dataset).
#' @param random.seed integer, by default radndom.seed = NULL implies that missing values are initially imputed by the mean of each variable. Other values leads to a random initialization
#' @param ncp Number of dimensions used by algorithm. Default 2.
#' @param coeff.ridge Value use in Regularized method.
#' @param out_file  Output log file location if file already exists log message will be added. If NULL no log will be produced.
#' @param maxiter maximal number of iteration in algorithm.
#' @param method used in imputation algorithm.
#' @param threshold for convergence.
#' @param imp_data If True data abute imputation requaierd for missMDA.reuse its return.
#' @author{   Julie Josse, Francois Husson (2016)  \doi{10.18637/jss.v070.i01}}
#'
#' @examples
#' {
#'   raw_data <- data.frame(
#'     a = as.factor(sample(c("red", "yellow", "blue", NA), 1000, replace = TRUE)),
#'     b = as.integer(1:1000),
#'     c = as.factor(sample(c("YES", "NO", NA), 1000, replace = TRUE)),
#'     d = runif(1000, 1, 10),
#'     e = as.factor(sample(c("YES", "NO"), 1000, replace = TRUE)),
#'     f = as.factor(sample(c("male", "female", "trans", "other", NA), 1000, replace = TRUE)))
#'
#'   # Prepering col_type
#'   col_type <- c("factor", "integer", "factor", "numeric", "factor", "factor")
#'
#'   percent_of_missing <- 1:6
#'   for (i in percent_of_missing) {
#'     percent_of_missing[i] <- 100 * (sum(is.na(raw_data[, i])) / nrow(raw_data))
#'   }
#'
#'
#'   imp_data <- missMDA_MFA(raw_data, col_type, percent_of_missing)
#'
#'   # Check if all missing value was imputed
#'   sum(is.na(imp_data)) == 0
#'   # TRUE
#' }
#' @references   Julie Josse, Francois Husson (2016). missMDA: A Package for Handling Missing Values in Multivariate Data Analysis. Journal of Statistical Software, 70(1), 1-31. doi:10.18637/jss.v070.i01
#' @import missMDA
#' @return Return one data.frame with imputed values.
#' @export



missMDA_MFA <- function(df, col_type=NULL, percent_of_missing=NULL, random.seed = NULL, ncp = 2, col_0_1 = FALSE, maxiter = 1000,
  coeff.ridge = 1, threshold = 1e-6, method = "Regularized", out_file = NULL,imp_data=FALSE){

  #Column informations
  if(is.null(col_type)){
    col_type <- 1:ncol(df)
    for ( i in col_type){
      col_type[i] <- class(df[,i])
    }
  }

  if(is.null(percent_of_missing)){
    percent_of_missing <- 1:ncol(df)
    for ( i in percent_of_missing){
      percent_of_missing[i] <- sum(is.na(df[,i]))/nrow(df)
    }
  }


  if (!is.null(out_file)) {
    write("MFA", file = out_file, append = TRUE)
  }

  if (sum(is.na(df)) == 0) {
    return(df)
  }

  # Creating gropus
  col_type_simpler <- ifelse(col_type == "factor", "n", "s")


  groups <- c(99999999)
  type <- c("remove")
  counter <- 1
  for (i in 1:(length(col_type_simpler) - 1)) {
    flag <- col_type_simpler[i + 1]


    if (flag == col_type_simpler[i]) {
      counter <- counter + 1
      if (i + 1 == length(col_type_simpler)) {
        groups <- c(groups, counter)
        type <- c(type, col_type_simpler[i + 1])
      }
    }
    if (flag != col_type_simpler[i]) {
      groups <- c(groups, counter)
      type <- c(type, col_type_simpler[i])
      counter <- 1
      if (i + 1 == length(col_type_simpler)) {
        groups <- c(groups, counter)
        type <- c(type, col_type_simpler[i + 1])
      }
    }
  }
  groups <- groups[-1]
  type <- type[-1]
  if (length(groups) == 1) {

    groups <- c(floor(groups / 2), groups - floor(groups / 2))
    type <- rep(type[1], 2)
  }
  # Imputation
  no_ok <- FALSE


  tryCatch({
    # tryning with selected ncp
    final <- missMDA::imputeMFA(df, group = groups, type = type, ncp = ncp, method = method, threshold = threshold, maxiter = maxiter, coeff.ridge = coeff.ridge)$completeObs
  }, error = function(e) {
    no_ok <- TRUE
  }
  )
  tryCatch({
    # trying with ncp =1
    if (no_ok | !exists("final")) {
      final <- missMDA::imputeMFA(df, group = groups, type = type, ncp = 1, method = method, threshold = threshold, maxiter = maxiter, coeff.ridge = coeff.ridge)$completeObs
      ncp <- 1
    }
    if (!is.null(out_file)) {
      write("  OK", file = out_file, append = TRUE)

    }
  }, error = function(e) {
    if (!is.null(out_file)) {
      write(as.character(e), file = out_file, append = TRUE)
    }

    if(as.character(e)=="dim(X) must have a positive length"){
      print("Problem probably with algorithm implementation ")
    }



    if(as.character(e)=="algorithm fails to converge"){
      print("Problem probably with algorithm implementation ")
    }



    stop(e)
  })
  for (i in colnames(df)[(col_type == "factor")]) {

    if (!setequal(as.character(unique(na.omit(df[, i]))), levels(final[, i]))) {

      reg_exp <- paste0(".*", i)
      levels(final[, i]) <- substr(sub(reg_exp, "", levels(final[, i])), start = 2, stop = 9999)
    }
  }
  for (i in colnames(df)[(col_type == "factor")]) {

    if (!setequal(levels(na.omit(df[, i])), levels(final[, i]))) {

      levels(final[, i]) <- c(levels(na.omit(df[, i])))
    }
  }
  # adding 0_1 columns

  if (col_0_1) {
    columns_with_missing <- (as.data.frame(is.na(df)) * 1)[, percent_of_missing > 0]
    colnames(columns_with_missing) <- paste(colnames(columns_with_missing), "where", sep = "_")
    final <- cbind(final, columns_with_missing)
  }
  for (i in colnames(final)[col_type == "integer"]) {
    final[, i] <- as.integer(final[, i])
  }

  if(imp_data){return(list("data"=final,"groups"=groups,"type"= type,"ncp"=ncp))}
  return(final)
}
