% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PipeOpVIM_HD.R
\name{PipeOpVIM_HD}
\alias{PipeOpVIM_HD}
\title{PipeOpVIM_HD}
\description{
Implements Hot Deck methods as mlr3 pipeline more about VIM_HD \code{\link{autotune_VIM_hotdeck}}
}
\section{Input and Output Channels}{

Input and output channels are inherited from \code{\link{PipeOpImpute}}.
}

\section{Parameters}{

The parameters include inherited from [`PipeOpImpute`], as well as: \cr
\itemize{
\item \code{id} :: \code{character(1)}\cr
Identifier of resulting object, default \code{"imput_VIM_HD"}.
\item \code{out_fill} :: \code{character(1)}\cr
Output log file location. If file already exists log message will be added. If NULL no log will be produced, default \code{NULL}.
}
}

\examples{
{
  graph <- PipeOpVIM_HD$new() \%>>\% mlr3learners::LearnerClassifGlmnet$new()
  graph_learner <- GraphLearner$new(graph)

  # Task with NA

  resample(tsk("pima"), graph_learner, rsmp("cv", folds = 3))
}
}
\section{Super classes}{
\code{\link[mlr3pipelines:PipeOp]{mlr3pipelines::PipeOp}} -> \code{\link[mlr3pipelines:PipeOpImpute]{mlr3pipelines::PipeOpImpute}} -> \code{VIM_HD_imputation}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-new}{\code{PipeOpVIM_HD$new()}}
\item \href{#method-clone}{\code{PipeOpVIM_HD$clone()}}
}
}
\if{html}{
\out{<details open ><summary>Inherited methods</summary>}
\itemize{
\item \out{<span class="pkg-link" data-pkg="mlr3pipelines" data-topic="PipeOp" data-id="predict">}\href{../../mlr3pipelines/html/PipeOp.html#method-predict}{\code{mlr3pipelines::PipeOp$predict()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="mlr3pipelines" data-topic="PipeOp" data-id="print">}\href{../../mlr3pipelines/html/PipeOp.html#method-print}{\code{mlr3pipelines::PipeOp$print()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="mlr3pipelines" data-topic="PipeOp" data-id="train">}\href{../../mlr3pipelines/html/PipeOp.html#method-train}{\code{mlr3pipelines::PipeOp$train()}}\out{</span>}
}
\out{</details>}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-new"></a>}}
\if{latex}{\out{\hypertarget{method-new}{}}}
\subsection{Method \code{new()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{PipeOpVIM_HD$new(id = "impute_VIM_HD_B", out_file = NULL)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-clone"></a>}}
\if{latex}{\out{\hypertarget{method-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{PipeOpVIM_HD$clone(deep = FALSE)}\if{html}{\out{</div>}}
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
