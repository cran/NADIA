% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PipeOpHist_B.R
\name{PipeOpHist_B}
\alias{PipeOpHist_B}
\title{PipeOpHist_B}
\description{
Impute numerical features by histogram in approach B (independently during the training and prediction phase).
}
\section{Input and Output Channels}{

Input and output channels are inherited from \code{\link{PipeOpImpute}}.
}

\section{Parameters}{

The parameters include inherited from [`PipeOpImpute`], as well as: \cr
\itemize{
\item \code{id} :: \code{character(1)}\cr
Identifier of resulting object, default `"impute_hist_B"`.
}
}

\examples{
\donttest{

# Using debug learner for example purpose

  graph <- PipeOpHist_B$new() \%>>\%  LearnerClassifDebug$new()
  graph_learner <- GraphLearner$new(graph)
  set.seed(1)
  resample(tsk("pima"), graph_learner, rsmp("cv", folds = 3))
}
}
\section{Super classes}{
\code{\link[mlr3pipelines:PipeOp]{mlr3pipelines::PipeOp}} -> \code{\link[mlr3pipelines:PipeOpImpute]{mlr3pipelines::PipeOpImpute}} -> \code{Hist_B_imputation}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-Hist_B_imputation-new}{\code{PipeOpHist_B$new()}}
\item \href{#method-Hist_B_imputation-clone}{\code{PipeOpHist_B$clone()}}
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
\if{html}{\out{<a id="method-Hist_B_imputation-new"></a>}}
\if{latex}{\out{\hypertarget{method-Hist_B_imputation-new}{}}}
\subsection{Method \code{new()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{PipeOpHist_B$new(id = "impute_hist_B", param_vals = list())}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Hist_B_imputation-clone"></a>}}
\if{latex}{\out{\hypertarget{method-Hist_B_imputation-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{PipeOpHist_B$clone(deep = FALSE)}\if{html}{\out{</div>}}
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
