\name{predict.gppr}
\alias{predict.gppr}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Generalised projection pursuit regression
}
\description{
Obtains linear predictor- or data-scale predictions for a fitted gppr object
}
\usage{
predict.gppr(object,newdata,type="link")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
a fitted gppr object
}
  \item{newdata}{
an optional data frame containing new predictor variable values.  If 'newdata' is omitted, then the predictions are made for the original data from which the gppr model was fitted.
}
  \item{type}{
the type of prediction required.  The default is the scale of the linear predictor, alternativels 'type="response"' gives expected values.
}
}


\value{
A vector of predictions.
}

\references{
M.B. Morrissey. in prep.
}
\author{
Michael Morrissey \email{michael.morrissey@st-andrews.ac.uk}
}


\seealso{
\code{\link{gppr}, \link{ppr},\link{gppr.gradients}}
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

# hist(predict(fit.func))
}
