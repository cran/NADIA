#' @title PipeOpVIM_IRMI
#' @name PipeOpVIM_IRMI
#'
#' @description
#' Implements IRMI methods as mlr3 pipeline, more about VIM_IRMI \code{\link{autotune_VIM_Irmi}}.
#'
#' @section Input and Output Channels:
#' Input and output channels are inherited from \code{\link{PipeOpImpute}}.
#'
#'
#' @section Parameters:
#' The parameters include inherited from [`PipeOpImpute`], as well as: \cr
#' \itemize{
#' \item \code{id} :: \code{character(1)}\cr
#' Identifier of resulting object, default \code{"imput_VIM_IRMI"}.
#' \item \code{eps} :: \code{double(1)}\cr
#' Threshold for convergence, default \code{5}.
#' \item \code{maxit} :: \code{integer(1)}\cr
#' Maximum number of iterations, default \code{100}
#' \item \code{step} :: \code{logical(1)}\cr
#' Stepwise model selection is applied when the parameter is set to TRUE, default \code{FALSE}.
#' \item \code{robust} :: \code{logical(1)}\cr
#' 	If TRUE, robust regression methods will be applied (it's impossible to set step=TRUE and robust=TRUE at the same time), default \code{FALSE}.
#' \item \code{init.method} :: \code{character(1)}\cr
#' Method for initialization of missing values (kNN or median), default \code{'kNN'}.
#' \item \code{force} :: \code{logical(1)}\cr
#' If TRUE, the algorithm tries to find a solution in any case by using different robust methods automatically (should be set FALSE for simulation), default \code{FALSE}.
#' \item \code{out_fill} :: \code{character(1)}\cr
#' Output log file location. If file already exists log message will be added. If NULL no log will be produced, default \code{NULL}.
#' }
#'
#' @examples
#' \donttest{
#'   graph <- PipeOpVIM_IRMI$new() %>>% mlr3learners::LearnerClassifGlmnet$new()
#'   graph_learner <- GraphLearner$new(graph)
#'
#'   # Task with NA
#'
#'   resample(TaskClassif$new('id',tsk('pima')$data(rows=1:100),
#'   'diabetes'), graph_learner, rsmp("cv",folds=2))
#' }
#' @export
PipeOpVIM_IRMI <- R6::R6Class("VIM_IRMI_imputation",
  lock_objects = FALSE,
  inherit = PipeOpImpute, # inherit from PipeOp
  public = list(
    initialize = function(id = "impute_VIM_IRMI_B", eps = 5, maxit = 100, step = FALSE, robust = FALSE, init.method = "kNN", force = FALSE,
      out_file = NULL) {
      super$initialize(id,
        whole_task_dependent = TRUE, packages = "NADIA", param_vals = list(
          eps = eps, maxit = maxit, step = step, robust = robust,
          init.method = init.method, force = force, out_file = out_file),
        param_set = ParamSet$new(list(
          "eps" = ParamDbl$new("eps", lower = 0, upper = Inf, default = 5, tags = "VIM_IRMI"),
          "maxit" = ParamInt$new("maxit", lower = 10, upper = Inf, default = 100, tags = "VIM_IRMI"),
          "step" = ParamLgl$new("step", default = FALSE, tags = "VIM_IRMI"),
          "robust" = ParamLgl$new("robust", default = FALSE, tags = "VIM_IRMI"),
          "init.method" = ParamFct$new("init.method", levels = c("kNN", "median"), default = "kNN", tags = "VIM_IRMI"),
          "force" = ParamLgl$new("force", default = FALSE, tags = "VIM_IRMI"),
          "out_file" = ParamUty$new("out_file", default = NULL, tags = "VIM_IRMI")

        ))
      )



      self$imputed <- FALSE
      self$column_counter <- NULL
      self$data_imputed <- NULL

    }), private = list(
    .train_imputer = function(feature, type, context) {

      imp_function <- function(data_to_impute) {

        data_to_impute <- as.data.frame(data_to_impute)
        # prepering arguments for function
        col_type <- 1:ncol(data_to_impute)
        for (i in col_type) {
          col_type[i] <- class(data_to_impute[, i])
        }
        percent_of_missing <- 1:ncol(data_to_impute)
        for (i in percent_of_missing) {
          percent_of_missing[i] <- (sum(is.na(data_to_impute[, i])) / length(data_to_impute[, 1])) * 100
        }
        col_miss <- colnames(data_to_impute)[percent_of_missing > 0]
        col_no_miss <- colnames(data_to_impute)[percent_of_missing == 0]



        data_imputed <- NADIA::autotune_VIM_Irmi(data_to_impute, col_type, percent_of_missing,
          eps = self$param_set$values$eps, maxit = self$param_set$values$maxit,
          step = self$param_set$values$step, robust = self$param_set$values$robust,
          init.method = self$param_set$values$init.method, force = self$param_set$values$force,
          out_file = self$param_set$values$out_file)



        return(data_imputed)
      }
      self$imputed_predict <- TRUE
      self$flag <- "train"

      if (!self$imputed) {
        self$column_counter <- ncol(context) + 1
        self$imputed <- TRUE
        data_to_impute <- cbind(feature, context)
        self$data_imputed <- imp_function(data_to_impute)
        colnames(self$data_imputed) <- self$state$context_cols

      }
      if (self$imputed) {
        self$column_counter <- self$column_counter - 1

      }
      if (self$column_counter == 0) {
        self$imputed <- FALSE
      }

      self$train_s <- TRUE

      self$action <- 3


      return(list("data_imputed" = self$data_imputed, "train_s" = self$train_s, "flag" = self$flag, "imputed_predict" = self$imputed_predict, "imputed" = self$imputed, "column_counter" = self$column_counter))

    },
    .impute = function(feature, type, model, context) {

      if (is.null(self$action)) {


        self$train_s <- TRUE
        self$flag <- "train"
        self$imputed_predict <- TRUE
        self$action <- 3
        self$data_imputed <- model$data_imputed
        self$imputed <- FALSE
        self$column_counter <- 0

      }
      imp_function <- function(data_to_impute) {

        data_to_impute <- as.data.frame(data_to_impute)
        # prepering arguments for function
        col_type <- 1:ncol(data_to_impute)
        for (i in col_type) {
          col_type[i] <- class(data_to_impute[, i])
        }
        percent_of_missing <- 1:ncol(data_to_impute)
        for (i in percent_of_missing) {
          percent_of_missing[i] <- (sum(is.na(data_to_impute[, i])) / length(data_to_impute[, 1])) * 100
        }



        data_imputed <- NADIA::autotune_VIM_Irmi(data_to_impute, col_type, percent_of_missing,
          eps = self$param_set$values$eps, maxit = self$param_set$values$maxit,
          step = self$param_set$values$step, robust = self$param_set$values$robust,
          init.method = self$param_set$values$init.method, force = self$param_set$values$force,
          out_file = self$param_set$values$out_file)



        return(data_imputed)
      }

      if (self$imputed) {
        feature <- self$data_imputed[, setdiff(colnames(self$data_imputed), colnames(context))]


      }
      if ((nrow(self$data_imputed) != nrow(context) | !self$train_s) & self$flag == "train") {
        self$imputed_predict <- FALSE
        self$flag <- "predict"
      }

      if (!self$imputed_predict) {
        data_to_impute <- cbind(feature, context)
        self$data_imputed <- imp_function(data_to_impute)
        colnames(self$data_imputed)[1] <- setdiff(self$state$context_cols, colnames(context))
        self$imputed_predict <- TRUE
      }


      if (self$imputed_predict & self$flag == "predict") {
        feature <- self$data_imputed[, setdiff(colnames(self$data_imputed), colnames(context))]

      }

      if (self$column_counter == 0 & self$flag == "train") {
        feature <- self$data_imputed[, setdiff(colnames(self$data_imputed), colnames(context))]
        self$flag <- "predict"
        self$imputed_predict <- FALSE
      }
      self$train_s <- FALSE

      return(feature)
    }

  )
)
