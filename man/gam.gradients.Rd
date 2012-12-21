\name{gam.gradients}
\alias{gam.gradients}

\title{
A function to calculate selection gradients from generalized additive model-based characterizions of fitness functions.
}

\description{
gam.gradients uses numerical approximations to the first and second order partial derivatives of population mean fitness with respect to population mean phenotype to obtain directional and quadratic selection gradients.
}

\usage{
gam.gradients(mod, phenotype, covariates = NULL, standardized = FALSE, 
          se.method = "boot.para", n.boot = 1000, 
          parallel = "no", ncpus = 1, refit.smooth = FALSE)
}

\arguments{
  \item{mod}{
a gam object.  Must include predictor variables specified by \code{phenotype}
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
  \item{refit.smooth}{
whether or not to re-estiamte smoothing parameters when \code{gam} objects are refitted in bootstrapping and permutation algorithms
}
}


\value{
A list. Element 1 is a table of estimates, standard errors and P-values, and element 2 contains the bootstrap or permutation values.
}
\references{
M.B. Morrissey and K. Sakrejda. in prep.
}
\author{
Michael Morrissey \email{michael.morrissey@st-andrews.ac.uk}
}


%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{gam.gradients},\link{moments.differentials},\link{gam}}
}
\examples{
# simulated data (stabilizing selection)
z<-rnorm(200,0,2)
W<-rpois(200,exp(1-0.3*z^2))
d<-as.data.frame(list(W=W,z=z))

# characterize the fitness function
library(mgcv)
ff<-gam(W~s(z),family='poisson',data=d)

# derive selection gradients
gam.gradients(mod=ff,phenotype="z",se.method='n',standardized=FALSE)$ests

# or gam.gradients() can be used to do the
# equivalent of a basic Lande and Arnold
# 1983 regression

LA<-gam(W~z+I(z^2),family='gaussian',data=d)
gam.gradients(mod=LA,phenotype="z",se.method='n',standardize=FALSE)$ests

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
