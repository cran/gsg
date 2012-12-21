\name{moments.differentials}
\alias{moments.differentials}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Calculates selection differentials directly from the differences in phenotypic moments before and after selection.
}
\description{
The calculations are based on the difference between the fitness-weighted moments (means, variances, covariances) of the phenotypic distribution and the unweighted moments.  For viability selection, this is simply the moments after minus the moments before, as there are two fitness classes, zero and one.
}
\usage{
moments.differentials(z, W, n.boot = 1000, standardized = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{z}{
phenotypic traits, a data frame, table, or array with individuals on rows and traits in columns
}
  \item{W}{
a vector of fitness (relative or absolute) of the same length as the number of indivdiuals represented in z
}
  \item{n.boot}{
number of bootstrap replicates to use for calculation of standard errors and P-values
}
  \item{standardized}{
whether or not to calculate variance-standardized selection differentials
}
}


\value{
A table containing the estimated directional and quadratic selection gradients, and if bootstrap-based standard errors are generated, columns containing those standard errors and associated P-values
}

\references{
M.B. Morrissey and K. Sakrejda. in prep.
}
\author{
Michael Morrissey \email{michael.morrissey@st-andrews.ac.uk}
}


\seealso{
\code{\link{gam.gradients}}
}
\examples{
# simulated data (stabilizing selection)
z<-rnorm(200,0,2)
W<-rpois(200,exp(1-0.3*z^2))
d<-as.data.frame(list(W=W,z=z))

# estimate selection coefficients by least-squares regression
moments.differentials(z=z,W=W)
# note that standardized differentials and gradients are trivially
# the same in a univariate analysis
}
