% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PipeOpMice_A.R
\name{PipeOpMice_A}
\alias{PipeOpMice_A}
\title{PipeOpMice_A}
\description{
Implements mice methods as mlr3 in A approach (training imputation model on training data and used a trained model on test data).
}
\details{
Code of used function was writen by \url{https://github.com/prockenschaub} more information aboute this aproche can be found here \url{https://github.com/amices/mice/issues/32}
}
\section{Input and Output Channels}{

Input and output channels are inherited from \code{\link{PipeOpImpute}}.
}

\section{Parameters}{

The parameters include inherited from [`PipeOpImpute`], as well as: \cr
\itemize{
\item \code{id} :: \code{character(1)}\cr
Identifier of resulting object, default \code{"imput_mice_A"}.
\item \code{m} :: \code{integer(1)}\cr
Number of datasets produced by mice, default \code{5}.
\item \code{maxit} :: \code{integer(1)}\cr
Maximum number of iterations for mice, default \code{5}.
\item \code{set_corr} :: \code{double(1)}\cr
Correlation or fraction of features used when optimize=FALSE. When correlation=FALSE, it represents a fraction of case to use in imputation for each variable, default \code{0.5}.
\item \code{random.seed} :: \code{integer(1)}\cr
Random seed, default \code{123}.
\item \code{correlation} :: \code{logical(1)}\cr
If set TRUE correlation is used, if set FALSE then fraction of case, default \code{TRUE}.
}
}

\examples{
\donttest{

 # Using debug learner for example purpose

  graph <- PipeOpMice_A$new() \%>>\% LearnerClassifDebug$new()
  graph_learner <- GraphLearner$new(graph)

  # Task with NA

  resample(tsk("pima"), graph_learner, rsmp("cv", folds = 3))
}

}
\section{Super classes}{
\code{\link[mlr3pipelines:PipeOp]{mlr3pipelines::PipeOp}} -> \code{\link[mlr3pipelines:PipeOpImpute]{mlr3pipelines::PipeOpImpute}} -> \code{mice_A_imputation}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-mice_A_imputation-new}{\code{PipeOpMice_A$new()}}
\item \href{#method-mice_A_imputation-clone}{\code{PipeOpMice_A$clone()}}
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
\if{html}{\out{<a id="method-mice_A_imputation-new"></a>}}
\if{latex}{\out{\hypertarget{method-mice_A_imputation-new}{}}}
\subsection{Method \code{new()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{PipeOpMice_A$new(
  id = "impute_mice_A",
  set_cor = 0.5,
  m = 5,
  maxit = 5,
  random.seed = 123,
  correlation = FALSE,
  methods = NULL
)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-mice_A_imputation-clone"></a>}}
\if{latex}{\out{\hypertarget{method-mice_A_imputation-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{PipeOpMice_A$clone(deep = FALSE)}\if{html}{\out{</div>}}
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
