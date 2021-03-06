% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/missMDA_FMAD_MCA_PCA.R
\name{missMDA_FMAD_MCA_PCA}
\alias{missMDA_FMAD_MCA_PCA}
\title{Perform imputation using MCA, PCA, or FMAD algorithm.}
\usage{
missMDA_FMAD_MCA_PCA(
  df,
  col_type = NULL,
  percent_of_missing = NULL,
  optimize_ncp = TRUE,
  set_ncp = 2,
  col_0_1 = FALSE,
  ncp.max = 5,
  return_one = TRUE,
  random.seed = 123,
  maxiter = 998,
  coeff.ridge = 1,
  threshold = 1e-06,
  method = "Regularized",
  out_file = NULL,
  return_ncp = FALSE
)
}
\arguments{
\item{df}{data.frame. Df to impute with column names and without target column.}

\item{col_type}{character vector. Vector containing column type names.}

\item{percent_of_missing}{numeric vector. Vector contatining percent of missing data in columns for example  c(0,1,0,0,11.3,..)}

\item{optimize_ncp}{logical. If true number of dimensions used to predict the missing entries will be optimized. If False by default ncp = 2 it's used.}

\item{set_ncp}{intiger >0. Number of dimensions used by algortims. Used only if optimize_ncp = Flase.}

\item{col_0_1}{Decaid if add bonus column informing where imputation been done. 0 - value was in dataset, 1 - value was imputed. Default False. (Works only for returning one dataset).}

\item{ncp.max}{integer corresponding to the maximum number of components to test. Default 5.}

\item{return_one}{One or many imputed sets will be returned. Default True.}

\item{random.seed}{integer, by default random.seed = NULL implies that missing values are initially imputed by the mean of each variable. Other values leads to a random initialization}

\item{maxiter}{maximal number of iteration in algortihm.}

\item{coeff.ridge}{Value use in Regularized method.}

\item{threshold}{threshold for convergence.}

\item{method}{method used in imputation algoritm.}

\item{out_file}{Output log file location if file already exists log message will be added. If NULL no log will be produced.}

\item{return_ncp}{Function should return used ncp value}
}
\value{
Retrun one imputed data.frame if retrun_one=True or list of imputed data.frames if retrun_one=False.
}
\description{
Function use missMDA package to perform data imputation. Function can found the best number of dimensions for this imputation.
User can choose whether to return one imputed dataset or list or imputed datasets form Multiple Imputation.
}
\details{
Function use different algorithm to adjust for variable types in df. For only numeric data PCA will be used. MCA for only categorical and FMAD for mixed. If optimize==TRUE function will try to find optimal ncp if its not possible default ncp=2 will be used. In some cases ncp=1 will be used if ncp=2 don't work. For multiple imputations, if set ncp don't work error will be return.
}
\examples{
{
  raw_data <- data.frame(
    a = as.factor(sample(c("red", "yellow", "blue", NA), 1000, replace = TRUE)),
    b = as.integer(1:1000),
    c = as.factor(sample(c("YES", "NO", NA), 1000, replace = TRUE)),
    d = runif(1000, 1, 10),
    e = as.factor(sample(c("YES", "NO"), 1000, replace = TRUE)),
    f = as.factor(sample(c("male", "female", "trans", "other", NA), 1000, replace = TRUE)))

  # Prepering col_type
  col_type <- c("factor", "integer", "factor", "numeric", "factor", "factor")

  percent_of_missing <- 1:6
  for (i in percent_of_missing) {
    percent_of_missing[i] <- 100 * (sum(is.na(raw_data[, i])) / nrow(raw_data))
  }


  imp_data <- missMDA_FMAD_MCA_PCA(raw_data, col_type, percent_of_missing, optimize_ncp = FALSE)
  # Check if all missing value was imputed
  sum(is.na(imp_data)) == 0
  # TRUE
}
}
\references{
Julie Josse, Francois Husson (2016). missMDA: A Package for Handling Missing Values in Multivariate Data Analysis. Journal of Statistical Software, 70(1), 1-31. doi:10.18637/jss.v070.i01
}
\author{
{ Julie Josse, Francois Husson (2016)   \doi{10.18637/jss.v070.i01}}
}
