% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PipeOPmissForest.R
\name{PipeOpmissForest}
\alias{PipeOpmissForest}
\title{PipeOpmissForest}
\description{
Implements missForest methods as mlr3 pipeline more about missForest \code{\link{autotune_missForest}}
}
\section{Input and Output Channels}{

Input and output channels are inherited from \code{\link{PipeOpImpute}}.
}

\section{Parameters}{

The parameters include inherited from [`PipeOpImpute`], as well as: \cr
\itemize{
\item \code{id} :: \code{character(1)}\cr
Identifier of resulting object, default \code{"imput_missForest"}.
\item \code{cores} :: \code{integer(1)}\cr
Number of threads used by parallel calculations. If NULL approximately half of available CPU cores will be used, default \code{NULL}.
\item \code{ntree_set} :: \code{integer(1)}\cr
Vector with \emph{number of trees} values for grid search, used only when optimize=TRUE, default \code{c(100,200,500,1000)}.
\item \code{mtry_set} :: \code{integer(1)}\cr
Vector with \emph{number of variables} values randomly sampled at each split, used only when optimize=TRUE, default \code{NULL}.
\item \code{parallel} :: \code{logical(1)}\cr
If TRUE parallel calculations are used, default \code{FALSE}.
\item \code{ntree} :: \code{integer(1)}\cr
ntree from missForest function, default \code{100}.
\item \code{optimize} :: \code{logical(1)}\cr
If set TRUE, function will optimize parameters of imputation automatically. If parameters will be tuned by other method, should be set to FALSE, default \code{FALSE}.
\item \code{mtry} :: \code{integer(1)}\cr
mtry from missForest function, default \code{NULL}.
\item \code{maxiter} :: \code{integer(1)}\cr
maxiter from missForest function, default \code{20}.
\item \code{maxnodes} :: \code{character(1)}\cr
maxnodes from missForest function, default \code{NULL}
\item \code{out_fill} :: \code{character(1)}\cr
Output log file location. If file already exists log message will be added. If NULL no log will be produced, default \code{NULL}.
}
}

\examples{
\donttest{

  # Using debug learner for example purpose

  graph <- PipeOpmissForest$new() \%>>\% LearnerClassifDebug$new()
  graph_learner <- GraphLearner$new(graph)

  # Task with NA

  resample(tsk("pima"), graph_learner, rsmp("cv", folds = 3))
}
}
\section{Super classes}{
\code{\link[mlr3pipelines:PipeOp]{mlr3pipelines::PipeOp}} -> \code{\link[mlr3pipelines:PipeOpImpute]{mlr3pipelines::PipeOpImpute}} -> \code{missForest_imputation}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-missForest_imputation-new}{\code{PipeOpmissForest$new()}}
\item \href{#method-missForest_imputation-clone}{\code{PipeOpmissForest$clone()}}
}
}
\if{html}{\out{
<details open><summary>Inherited methods</summary>
<ul>
<li><span class="pkg-link" data-pkg="mlr3pipelines" data-topic="PipeOp" data-id="help"><a href='../../mlr3pipelines/html/PipeOp.html#method-PipeOp-help'><code>mlr3pipelines::PipeOp$help()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mlr3pipelines" data-topic="PipeOp" data-id="predict"><a href='../../mlr3pipelines/html/PipeOp.html#method-PipeOp-predict'><code>mlr3pipelines::PipeOp$predict()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mlr3pipelines" data-topic="PipeOp" data-id="print"><a href='../../mlr3pipelines/html/PipeOp.html#method-PipeOp-print'><code>mlr3pipelines::PipeOp$print()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mlr3pipelines" data-topic="PipeOp" data-id="train"><a href='../../mlr3pipelines/html/PipeOp.html#method-PipeOp-train'><code>mlr3pipelines::PipeOp$train()</code></a></span></li>
</ul>
</details>
}}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-missForest_imputation-new"></a>}}
\if{latex}{\out{\hypertarget{method-missForest_imputation-new}{}}}
\subsection{Method \code{new()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{PipeOpmissForest$new(
  id = "impute_missForest_B",
  cores = NULL,
  ntree_set = c(100, 200, 500, 1000),
  mtry_set = NULL,
  parallel = FALSE,
  mtry = NULL,
  ntree = 100,
  optimize = FALSE,
  maxiter = 20,
  maxnodes = NULL,
  out_file = NULL
)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-missForest_imputation-clone"></a>}}
\if{latex}{\out{\hypertarget{method-missForest_imputation-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{PipeOpmissForest$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
