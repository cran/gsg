\name{gppr.gradients}
\alias{gppr.gradients}

\title{
A function to calculate selection gradients from generalized additive model-based characterizions of fitness functions.
}

\description{
gam.gradients uses numerical approximations to the first and second order partial derivatives of population mean fitness with respect to population mean phenotype to obtain directional and quadratic selection gradients.
}

\usage{
gppr.gradients(mod, phenotype, covariates = NULL, standardized = FALSE, 
          se.method = "boot.para", n.boot = 1000, 
          parallel = "no", ncpus = 1)
}

\arguments{
  \item{mod}{
a fitted object produced by \link{gppr}.  Must include predictor variables specified by \code{phenotype}
}
  \item{phenotype}{
a vector of one or two character strings specifying predictor variables in selection gradients are to be calculated
}
  \item{covariates}{
a character vector listing any covariates in the model \code{mod} for which selection gradients are not to be cacluated
}
  \item{se.method}{
the method by which to obtain standard errors and P-values of the selection gradients.  Options are 'n' for none, 'boot.para' for parametric bootstrapping (default), 'boot.case' for case bootstrapping, 'posterior' for an algorithm based on simulation from the multivariate normal approximation to the posterior distribution of the model parameters, and 'permute' for permutation-based P-values (no SEs).
}
  \item{n.boot}{
number of bootstrap replicates for evaluating statistical uncertainty in the selection gradients.
}
  \item{standardized}{
whether or not to standardize to unit variance to obtain selection gradient estimates that are comparable across traits and populations
}
  \item{parallel}{
whether or not to use parallel processing to speed up computation of bootstrap standard errors.  Default in 'no' for no parallel computing.  Under linux only, \code{parallel}='multicore' allows parallel processing, using the number of processors specified by \code{ncpus}
}
  \item{ncpus}{
the number of cpus to be used for parallel processing of bootstrap standard errors.  Only used under linux.
}
}


\value{
A list. Element 1 is a table of estimates, standard errors and P-values, and element 2 contains the bootstrap or permutation values.
}
\references{
M.B. Morrissey. in prep.
}
\author{
Michael Morrissey \email{michael.morrissey@st-andrews.ac.uk}
}


%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{gam.gradients},\link{gppr}}
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

gppr.gradients(mod= fit.func,phenotype=c("z1","z2"),se.method='n',standardize=FALSE)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
