% Generated by roxygen2 (4.0.1): do not edit by hand
\name{subset.list}
\alias{subset.list}
\title{Return subsets of a list which meet conditions.}
\usage{
\method{subset}{list}(x, subset = TRUE, select = ., ...,
  envir = parent.frame())
}
\arguments{
\item{x}{The list to be subsetted}

\item{subset}{A logical lambda expression of subsetting condition}

\item{select}{A lambda expression to evaluate for each selected item}

\item{...}{Additional parameters}

\item{envir}{The environment to evaluate mapping function}
}
\description{
Return subsets of a list which meet conditions.
}
\examples{
\dontrun{
x <- list(p1 = list(type="A",score=list(c1=10,c2=8)),
       p2 = list(type="B",score=list(c1=9,c2=9)),
       p3 = list(type="B",score=list(c1=9,c2=7)))
subset(x,type=="B")
subset(x,select=score)
subset(x,min(score$c1,score$c2) >= 8,data.frame(score))
do.call(rbind,
   subset(x,min(score$c1,score$c2) >= 8,data.frame(score)))
}
}

