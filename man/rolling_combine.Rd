% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rolling_combine.R
\name{rolling_combine}
\alias{rolling_combine}
\title{Dynamic Forecast Combination}
\usage{
rolling_combine(x, comb_method, criterion = NULL)
}
\arguments{
\item{x}{An object of class 'foreccomb'. Must contrain full training set and test set.}

\item{comb_method}{The combination method that should be used.}

\item{criterion}{Specifies loss criterion. Set criterion to either 'RMSE', 'MAE', or 'MAPE' for the methods \code{comb_TA}, \code{comb_WA},
\code{comb_EIG3}, and \code{comb_EIG4}, or to 'NULL' (default) for all other methods.}
}
\value{
Returns an object of class \code{foreccomb_res} that represents the results for the best-fit forecast combination method:
\item{Method}{Returns the best-fit forecast combination method.}
\item{Models}{Returns the individual input models that were used for the forecast combinations.}
\item{Weights}{Returns the combination weights obtained by applying the best-fit combination method to the training set.}
\item{Fitted}{Returns the fitted values of the combination method for the training set.}
\item{Accuracy_Train}{Returns range of summary measures of the forecast accuracy for the training set.}
\item{Forecasts_Test}{Returns forecasts produced by the combination method for the test set. Only returned if input included a forecast matrix for the test set.}
\item{Accuracy_Test}{Returns range of summary measures of the forecast accuracy for the test set. Only returned if input included a forecast matrix and a vector of actual values for the test set.}
\item{Input_Data}{Returns the data forwarded to the method.}
}
\description{
Computes the dynamic version of the combined forecast for a method included in the ForecastComb package.
}
\details{
The function \code{rolling_combine} allows to estimate a dynamic version of the other combination methods of the package in a
standardized way, i.e., it allows for time-varying weights. The function builds on the idea of time series cross-validation:
Taking the provided training set as starting point, the models are re-estimated at each period of the test set using a
revised (increased) training set.

Like univariate dynamic forecasting, the validation approach requires a full test set -- including the observed values.

The results are stored in an object of class 'foreccomb_res', for which separate plot and summary functions are provided.
}
\examples{
obs <- rnorm(100)
preds <- matrix(rnorm(1000, 1), 100, 10)
train_o<-obs[1:80]
train_p<-preds[1:80,]
test_o<-obs[81:100]
test_p<-preds[81:100,]

data<-foreccomb(train_o, train_p, test_o, test_p)

#Static forecast combination (for example OLS):
static_OLS <- comb_OLS(data)

#Dynamic forecast combination:
dyn_OLS <- rolling_combine(data, "comb_OLS")

}
\references{
Bergmeir, C., Hyndman, R.J., and Koo, B. (2015). A Note on the Validity of Cross-Validation
for Evaluating Time Series Prediction. \emph{Monash University, Deparment of Econometrics and
Business Statistics}, Working Paper No. 10/15.

Timmermann, A. (2006). Forecast Combinations. \emph{Handbook of Economic Forecasting}, \bold{1}, 135--196.
}
\seealso{
\code{\link{foreccomb}},
\code{\link{plot.foreccomb_res}},
\code{\link{summary.foreccomb_res}},
}
\author{
Christoph E. Weiss
}
\keyword{models}
