% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/missMDA_MFA.R
\name{missMDA_MFA}
\alias{missMDA_MFA}
\title{Perform imputation using MFA algorithm.}
\usage{
missMDA_MFA(
  df,
  col_type = NULL,
  percent_of_missing = NULL,
  random.seed = NULL,
  ncp = 2,
  col_0_1 = FALSE,
  maxiter = 1000,
  coeff.ridge = 1,
  threshold = 1e-06,
  method = "Regularized",
  out_file = NULL,
  imp_data = FALSE
)
}
\arguments{
\item{df}{data.frame. Df to impute with column names and without target column.}

\item{col_type}{character vector. Vector containing column type names.}

\item{percent_of_missing}{numeric vector. Vector contatining percent of missing data in columns for example  c(0,1,0,0,11.3,..)}

\item{random.seed}{integer, by default radndom.seed = NULL implies that missing values are initially imputed by the mean of each variable. Other values leads to a random initialization}

\item{ncp}{Number of dimensions used by algorithm. Default 2.}

\item{col_0_1}{Decaid if add bonus column informing where imputation been done. 0 - value was in dataset, 1 - value was imputed. Default False. (Works only for returning one dataset).}

\item{maxiter}{maximal number of iteration in algorithm.}

\item{coeff.ridge}{Value use in Regularized method.}

\item{threshold}{for convergence.}

\item{method}{used in imputation algorithm.}

\item{out_file}{Output log file location if file already exists log message will be added. If NULL no log will be produced.}

\item{imp_data}{If True data abute imputation requaierd for missMDA.reuse its return.}
}
\value{
Return one data.frame with imputed values.
}
\description{
Function use MFA (Multiple Factor Analysis) to impute missing data.
}
\details{
Groups are created using the original column order and taking as much variable to one group as possible. MFA requires selecting group type but numeric types can only be set as 'c' - centered and 's' - scale to unit variance.
It's impossible to provide these conditions so numeric type is always set as 's'.  Because of that imputation can depend from column order. In this function, no param is set automatically but if selected ncp don't work function will try use ncp=1.
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


  imp_data <- missMDA_MFA(raw_data, col_type, percent_of_missing)

  # Check if all missing value was imputed
  sum(is.na(imp_data)) == 0
  # TRUE
}
}
\references{
Julie Josse, Francois Husson (2016). missMDA: A Package for Handling Missing Values in Multivariate Data Analysis. Journal of Statistical Software, 70(1), 1-31. doi:10.18637/jss.v070.i01
}
\author{
{   Julie Josse, Francois Husson (2016)  \doi{10.18637/jss.v070.i01}}
}
