\name{fitness.landscape}
\alias{fitness.landscape}
\title{
A function to estimate fitness landscapes, i.e. the relationship between popualtion mean fitness and population mean phenotype.
}
\description{
\code{fitness.landscape()} takes a fitness function, i.e., the relationship between fitness and indivdiual phenotype, as characterized using the function \code{gam()} from the package mgcv, and calculates a corresponding fitness landscape in one or two dimensions
}
\usage{
fitness.landscape(mod, phenotype, covariates = NULL, points = NULL, 
        plt.density = 25, PI.method = "boot.para", 
        PI.interval = c(0.25, 0.75), n.boot = 50, refit.smooth = FALSE,
        parallel = "no", ncpus = 1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mod}{
a gam object.  Must include predictor variables specified by \code{phenotype}
}
  \item{phenotype}{
a vector of one or two character strings specifying predictor variables in \code{mod} that are the phenotypic traits with respect to which the fitness landscape is to be calculated
}
  \item{covariates}{
a character vector listing any covariates in the model \code{mod} to be excluded from chanracterization of the fitness landscape
}
  \item{points}{
(optional) a matrix, array, or data frame with traits in columns and points in rows, specifying the series of points at which to evaluate the estimated fitness landscape.  If missing, the fitness landscape is evaluated at points from one standard deviation below, to one standard deviation above the mean values, at as many points as specified by \code{plt.density}
}
  \item{plt.density}{
(optional) the number of points (per phenotypic trait) at which to evaluate the fitness landscape.  only used if \code{points} is NULL
}
  \item{PI.method}{
the method by which to obtain a prediction interval for the fitness landscape.  Options are 'n' for none, 'boot.para' for parametric bootstrapping, and 'boot.case' for case bootstrapping.
}
  \item{PI.interval}{
the upper and lower bounds of the prediction interval.  Defaults to c(0.5, 0.75) in order to generate a prediction interval that is interpretable similarly to a standard error.
}
  \item{n.boot}{
number of bootstrap replicates for evaluating the prediction interval of the fitness landscape
}
  \item{refit.smooth}{
whether or not to re-estiamte smoothing parameters when \code{gam} objects are refitted in bootstrapping and permutation algorithms
}
  \item{parallel}{
whether or not to use parallel processing to speed up computation of bootstrap prediction intervals.  Default in 'no' for no parallel computing.  Under linux only, \code{parallel}='multicore' allows parallel processing, using the number of processors specified by \code{ncpus}
}
  \item{ncpus}{
the number of cpus to be used for parallel processing of bootstrap prediction intervals.  Only used under linux.
}
}

\value{

\item{$points}{the points at which the fitness landscape was evaluated}
\item{$Wbar}{population mean absolute fitness at \code{points}}
\item{$WbarPI}{bounds of the prediction interval of \code{Wbar} at \code{points}}

}
\references{
M.B. Morrissey and K. Sakrejda. in prep.
}
\author{
Michael Morrissey \email{michael.morrissey@st-andrews.ac.uk}
}
\note{
Fitness landscapes are hypothetical constructs used to provide a visual representation of the magnitude of selection.  Care must be taken in the interpretation of these landscapes as the increase population mean fitness that would actually be realized from a given amount of selection.  This is because there are many assumptions, such as independence of evolution of the mean and variance, which are in fact likely to scale together, lack of density dependence of population growth (i.e. fitness), the assumption that evolution of the trait itself does not change the environment, etc.
}

\seealso{
\code{\link{gam.gradients},\link{moments.differentials},\link{gam}}
}

\examples{
# simulated data (stabilizing selection)
z<-rnorm(200,0,2)
W<-rpois(200,exp(1-1*z^2))
d<-as.data.frame(list(W=W,z=z))

# characterize the fitness function
library(mgcv)
ff<-gam(W~s(z),family='poisson',data=d)

# characterize fitness landscape
fl<-fitness.landscape(mod=ff,phenotype="z",PI.method='n')

# (not run) plotting
# plot(fl$points[,1],fl$Wbar,type='l')
# lines(fl$points[,1],fl$WbarPI[1,],lty='dashed')
# lines(fl$points[,1],fl$WbarPI[2,],lty='dashed')

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
