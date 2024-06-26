% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/comb_BG.R
\name{comb_BG}
\alias{comb_BG}
\title{Bates/Granger (1969) Forecast Combination Approach}
\usage{
comb_BG(x)
}
\arguments{
\item{x}{An object of class \code{foreccomb}. Contains training set (actual values + matrix of model forecasts) and optionally a test set.}
}
\value{
Returns an object of class \code{foreccomb_res} with the following components:
\item{Method}{Returns the used forecast combination method.}
\item{Models}{Returns the individual input models that were used for the forecast combinations.}
\item{Weights}{Returns the combination weights obtained by applying the combination method to the training set.}
\item{Fitted}{Returns the fitted values of the combination method for the training set.}
\item{Accuracy_Train}{Returns range of summary measures of the forecast accuracy for the training set.}
\item{Forecasts_Test}{Returns forecasts produced by the combination method for the test set. Only returned if input included a forecast matrix for the test set.}
\item{Accuracy_Test}{Returns range of summary measures of the forecast accuracy for the test set. Only returned if input included a forecast matrix and a vector of actual values for the test set.}
\item{Input_Data}{Returns the data forwarded to the method.}
}
\description{
Computes forecast combination weights according to the approach by Bates and Granger (1969) and produces forecasts for the test set, if provided.
}
\details{
In their seminal paper, Bates and Granger (1969) introduce the idea of combining forecasts. Their approach builds on portfolio diversification theory and uses the diagonal
elements of the estimated mean squared prediction error matrix in order to compute combination weights:

\deqn{w_i^{BG} = \frac{\hat{\sigma}^{-2} (i)}{\Sigma_{j=1}^N  \hat{\sigma}^{-2} (j)}}{w_i = \hat{\sigma}^{-2} (i) / \Sigma_{j=1}^N  \hat{\sigma}^{-2} (j)}

where \eqn{\hat{\sigma}^{-2} (i)} is the estimated mean squared prediction error of the i-th model.

The combined forecast is then obtained by:

\deqn{\hat{y}_t = {\mathbf{f}_{t}}'\mathbf{w}^{BG}}{\hat{y}_t = (f_t)'w}

Their approach ignores correlation between forecast models due to difficulties in precisely estimating the covariance matrix.
}
\examples{
obs <- rnorm(100)
preds <- matrix(rnorm(1000, 1), 100, 10)
train_o<-obs[1:80]
train_p<-preds[1:80,]
test_o<-obs[81:100]
test_p<-preds[81:100,]

data<-foreccomb(train_o, train_p, test_o, test_p)
comb_BG(data)

}
\references{
Bates, J. M., and Granger, C. W. (1969). The Combination of Forecasts. \emph{Journal of the Operational Research Society}, \bold{20(4)}, 451--468.

Timmermann, A. (2006). Forecast Combinations. In: Elliott, G., Granger, C. W. J., and Timmermann, A. (Eds.), \emph{Handbook of Economic Forecasting},
\bold{1}, 135--196.
}
\seealso{
\code{\link{foreccomb}},
\code{\link{plot.foreccomb_res}},
\code{\link{summary.foreccomb_res}},
\code{\link[forecast]{accuracy}}
}
\author{
Christoph E. Weiss and Gernot R. Roetzer
}
\keyword{models}
