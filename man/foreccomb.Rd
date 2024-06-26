% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/foreccomb.R
\name{foreccomb}
\alias{foreccomb}
\title{Format Raw Data for Forecast Combination}
\usage{
foreccomb(
  observed_vector,
  prediction_matrix,
  newobs = NULL,
  newpreds = NULL,
  byrow = FALSE,
  na.impute = TRUE,
  criterion = "RMSE"
)
}
\arguments{
\item{observed_vector}{A vector or univariate time series; contains \sQuote{actual values} for training set.}

\item{prediction_matrix}{A matrix or multivariate time series; contains individual model forecasts for training set.}

\item{newobs}{A vector or univariate time series; contains \sQuote{actual values} if a test set is used (optional).}

\item{newpreds}{A matrix or multivariate time series; contains individual model forecasts if a test set is used (optional). Does not
require specification of \code{newobs} -- in the case in which a forecaster only wants to train the forecast combination method
with a training set and apply it to future individual model forecasts, only \code{newpreds} is required, not \code{newobs}.}

\item{byrow}{logical. The default (\code{FALSE}) assumes that each column of the forecast matrices (\code{prediction_matrix} and -- if
specified -- \code{newpreds}) contains forecasts from one forecast model; if each row of the matrices contains forecasts from
one forecast model, set to \code{TRUE}.}

\item{na.impute}{logical. The default (\code{TRUE}) behavior is to impute missing values via the cross-validated spline approach of
the \code{mtsdi} package. If set to \code{FALSE}, forecasts with missing values will be removed. Missing values in the observed data are never
imputed.}

\item{criterion}{One of \code{"RMSE"} (default), \code{"MAE"}, or \code{"MAPE"}. Is only used if \code{prediction_matrix} is not full rank: The algorithm
checks which models are causing perfect collinearity and the one with the worst individual accuracy (according to the chosen
criterion) is removed.}
}
\value{
Returns an object of class \code{foreccomb}.
}
\description{
Structures cross-sectional input data (individual model forecasts) for forecast combination. Stores data as S3 class
\code{foreccomb} that serves as input to the forecast combination techniques. Handles missing value imputation (optional) and resolves
problems due to perfect collinearity.
}
\details{
The function imports the column names of the prediction matrix (if \code{byrow = FALSE}, otherwise the row names) as model names;
if no column names are specified, generic model names are created.

The missing value imputation algorithm is a modified version of the EM algorithm for imputation that is applicable to time series
data - accounting for correlation between the forecasting models and time structure of the series itself. A smooth spline is
fitted to each of the time series at each iteration. The degrees of freedom of each spline are chosen by cross-validation.

Forecast combination relies on the lack of perfect collinearity. The test for this condition checks if \code{prediction_matrix} is full
rank. In the presence of perfect collinearity, the iterative algorithm identifies the subset of forecasting models that are causing
linear dependence and removes the one among them that has the lowest accuracy (according to a selected criterion, default is RMSE).
This procedure is repeated until the revised prediction matrix is full rank.
}
\examples{
obs <- rnorm(100)
preds <- matrix(rnorm(1000, 1), 100, 10)
train_o<-obs[1:80]
train_p<-preds[1:80,]
test_o<-obs[81:100]
test_p<-preds[81:100,]

## Example with a training set only:
foreccomb(train_o, train_p)

## Example with a training set and future individual forecasts:
foreccomb(train_o, train_p, newpreds=test_p)

## Example with a training set and a full test set:
foreccomb(train_o, train_p, test_o, test_p)

## Example with forecast models being stored in rows:
preds_row <- matrix(rnorm(1000, 1), 10, 100)
train_p_row <- preds_row[,1:80]
foreccomb(train_o, train_p_row, byrow = TRUE)

## Example with NA imputation:
train_p_na <- train_p
train_p_na[2,3] <- NA
foreccomb(train_o, train_p_na, na.impute = TRUE)

## Example with perfect collinearity:
train_p[,2] <- 0.8*train_p[,1] + 0.4*train_p[,8]
foreccomb(train_o, train_p, criterion="RMSE")

}
\references{
Junger, W. L., Ponce de Leon, A., and Santos, N. (2003). Missing Data Imputation in Multivariate Time Series
via EM Algorithm. \emph{Cadernos do IME}, \bold{15}, 8--21.

Dempster, A., Laird, N., and Rubin D. (1977). Maximum Likelihood from Incomplete Data via the EM Algorithm.
\emph{Journal of the Royal Statistical Society, Series B}, \bold{39(1)}, 1--38.
}
\seealso{
\code{\link[mtsdi]{mnimput}},
\code{\link[Matrix]{rankMatrix}}
}
\author{
Christoph E. Weiss, Gernot R. Roetzer
}
\keyword{manip}
