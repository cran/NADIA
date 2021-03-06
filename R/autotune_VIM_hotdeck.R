#' Hot-Deck imputation using VIM package.
#'
#'
#' @description Function perform hotdeck function from VIM package. Any tunable parameters aren't available in this algorithm.
#'
#'
#' @param df data.frame. Df to impute with column names and without  target column.
#' @param percent_of_missing numeric vector. Vector contatining percent of missing data in columns for example  c(0,1,0,0,11.3,..)
#' @import VIM
#' @param col_0_1 decide if add bonus column informing where imputation been done. 0 - value was in dataset, 1 - value was imputed. Default False.
#' @param out_file  Output log file location if file already exists log message will be added. If NULL no log will be produced.
#' @references    Alexander Kowarik, Matthias Templ (2016). Imputation with the R Package VIM. Journal of Statistical Software, 74(7), 1-16. doi:10.18637/jss.v074.i07
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
#'   imp_data <- autotune_VIM_hotdeck(raw_data, percent_of_missing)
#'
#'   # Check if all missing value was imputed
#'   sum(is.na(imp_data)) == 0
#'   # TRUE
#' }
#' @return Return data.frame with imputed values.
#'
#'
#'@author{ Alexander Kowarik, Matthias Templ (2016) \doi{10.18637/jss.v074.i07}}
#'
#'
#' @export

autotune_VIM_hotdeck <- function(df, percent_of_missing=NULL, col_0_1 = FALSE, out_file = NULL) {


  if(is.null(percent_of_missing)){
    percent_of_missing <- 1:ncol(df)
    for ( i in percent_of_missing){
      percent_of_missing[i] <- sum(is.na(df[,i]))/nrow(df)
    }
  }

  if (!is.null(out_file)) {
    write("VIM_HD", file = out_file, append = TRUE)
  }
  tryCatch({
    final <- VIM::hotdeck(df, imp_var = FALSE)
    if (!is.null(out_file)) {
      write("  OK", file = out_file, append = TRUE)
    }
  }, error = function(e) {
    if (!is.null(out_file)) {
      write(as.character(e), file = out_file, append = TRUE)
    }
    stop(e)
  }

  )
  if (col_0_1) {
    columns_with_missing <- (as.data.frame(is.na(df)) * 1)[, percent_of_missing > 0]
    colnames(columns_with_missing) <- paste(colnames(columns_with_missing), "where", sep = "_")
    final <- cbind(final, columns_with_missing)
  }
  return(final)



}
