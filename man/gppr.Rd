\name{gppr}
\alias{gppr}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Generalised projection pursuit regression
}
\description{
Performs generalized projection pursuit regression for binary and Poisson response variables.  Wraps ppr from package stats in an iterative re-weighting algorithm.  Included in package gsg to support inference of the form of natural selection, and for inference of selection gradients from projection pursuit regression-based inference of fitness functions.
}
\usage{
gppr(y, xterms, data, nterms = 1, tol = 0.001, gcvpen = 1, 
      maxit = 50, family = 'binomial', max.terms = 2)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{y}{
response variable, e.g., absolute fitness
}
  \item{xterms}{
names of predictor variables in data
}
  \item{data}{
a data frame containing columns with names matching xterms
}
  \item{nterms}{
number of terms to include in the final model
}
  \item{tol}{
maximum sum of relative changes in linear predictors between iterations
}
  \item{gcvpen}{
penalty used for each degree of freedom in GCV selection for spline ridge functions
}
  \item{maxit}{
maximum number if iterations of the iterative re-weighting procedure
}
  \item{family}{
distribution of the response variable, currently 'binomial' and 'Poisson' are supported
}
  \item{max.terms}{
the maximum number of terms to choose from when building the model
}
  \item{...}{
other parameters passed to ppr
}
}


\value{
A gppr object, which contains a ppr object, plus information information pertaining to the iterative re-weighting procedure.  Most of these repeat arguments passed to gppr(), also included are:
  \item{iterations}{
the number of iterations of the iterative re-weighting procedure that were performed
}
  \item{f}{
the formula passed to ppr, constructed from xterms
}
}

\references{
M.B. Morrissey. in prep.
}
\author{
Michael Morrissey \email{michael.morrissey@st-andrews.ac.uk}
}


\seealso{
\code{\link{predict.gppr}, \link{ppr},\link{gppr.gradients}}
}
\examples{
# simulated data (two traits, stabilizing selection on trait 1)
n<-250
z<-cbind(rnorm(n,0,1),rnorm(n,0,1))
W<-rpois(n,exp(2-0.6*z[,1]^2))
d<-as.data.frame(cbind(W,z))
names(d)<-c("W","z1","z2")

fit.func<-gppr(y="W",xterms=c("z1","z2"),data=d,family="poisson",
   nterms=2,max.terms=2)

# direction of axes, and their loadings
fit.func$alpha
fit.func$beta

## not run - plot ridge functions (linear predictor scale)
# par(mfrow=c(1,2))
# plot(fit.func)
}
