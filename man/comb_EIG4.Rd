% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/comb_EIG4.R
\name{comb_EIG4}
\alias{comb_EIG4}
\title{Trimmed Bias-Corrected Eigenvector Forecast Combination}
\usage{
comb_EIG4(x, ntop_pred = NULL, criterion = "RMSE")
}
\arguments{
\item{x}{An object of class \code{foreccomb}. Contains training set (actual values + matrix of model forecasts) and optionally a test set.}

\item{ntop_pred}{Specifies the number of retained predictors. If \code{NULL} (default), the inbuilt optimization algorithm selects this number.}

\item{criterion}{If \code{ntop_pred} is not specified, a selection criterion is required for the optimization algorithm: one of "MAE", "MAPE",
or "RMSE". If \code{ntop_pred} is selected by the user, \code{criterion} should be set to \code{NULL} (default).}
}
\value{
Returns an object of class \code{foreccomb_res} with the following components:
\item{Method}{Returns the used forecast combination method.}
\item{Models}{Returns the individual input models that were used for the forecast combinations.}
\item{Intercept}{Returns the intercept (bias correction).}
\item{Weights}{Returns the combination weights obtained by applying the combination method to the training set.}
\item{Top_Predictors}{Number of retained predictors.}
\item{Ranking}{Ranking of the predictors that determines which models are removed in the trimming step.}
\item{Fitted}{Returns the fitted values of the combination method for the training set.}
\item{Accuracy_Train}{Returns range of summary measures of the forecast accuracy for the training set.}
\item{Forecasts_Test}{Returns forecasts produced by the combination method for the test set. Only returned if input included a forecast matrix for the test set.}
\item{Accuracy_Test}{Returns range of summary measures of the forecast accuracy for the test set. Only returned if input included a forecast matrix and a vector of actual values for the test set.}
\item{Input_Data}{Returns the data forwarded to the method.}
}
\description{
Computes forecast combination weights according to the trimmed bias-corrected  eigenvector approach by Hsiao and Wan (2014) and produces forecasts for the test set, if provided.
}
\details{
The underlying methodology of the trimmed bias-corrected eigenvector approach by Hsiao and Wan (2014) is the same as their
\code{\link[=comb_EIG2]{bias-corrected eigenvector approach}}. The only difference is that the bias-corrected trimmed eigenvector approach
pre-selects the models that serve as input for the forecast combination, only a subset of the available forecast models is retained,
while the models with the worst performance are discarded.

The number of retained forecast models is controlled via \code{ntop_pred}. The user can choose whether to select this number, or leave the selection
to the inbuilt optimization algorithm (in that case \code{ntop_pred = NULL}). If the optimization algorithm should select the best number of
retained models, the user must select the optimization \code{criterion}: MAE, MAPE, or RMSE. After this trimming step, the weights, the intercept and the
combined forecast are computed in the same way as in the \code{\link[=comb_EIG2]{bias-corrected eigenvector approach}}.

The bias-corrected trimmed eigenvector approach combines the strengths of the \cr
\code{\link[=comb_EIG2]{bias-corrected eigenvector approach}} and the \code{\link[=comb_EIG3]{trimmed eigenvector approach}}.
}
\examples{
obs <- rnorm(100)
preds <- matrix(rnorm(1000, 1), 100, 10)
train_o<-obs[1:80]
train_p<-preds[1:80,]
test_o<-obs[81:100]
test_p<-preds[81:100,]

## Number of retained models selected by the user:
data<-foreccomb(train_o, train_p, test_o, test_p)
comb_EIG4(data, ntop_pred = 2, criterion = NULL)

## Number of retained models selected by algorithm:
data<-foreccomb(train_o, train_p, test_o, test_p)
comb_EIG4(data, ntop_pred = NULL, criterion = "RMSE")

}
\references{
Hsiao, C., and Wan, S. K. (2014). Is There An Optimal Forecast Combination? \emph{Journal of Econometrics}, \bold{178(2)}, 294--309.
}
\seealso{
\code{\link{comb_EIG2}}
\code{\link{comb_EIG3}}
\code{\link[ForecastComb]{foreccomb}},
\code{\link[ForecastComb]{plot.foreccomb_res}},
\code{\link[ForecastComb]{summary.foreccomb_res}},
\code{\link[forecast]{accuracy}}
}
\author{
Christoph E. Weiss and Gernot R. Roetzer
}
\keyword{models}
