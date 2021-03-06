% Generated by roxygen2 (4.0.1): do not edit by hand
\name{list.match}
\alias{list.match}
\title{Select members of a list that match given regex pattern}
\usage{
list.match(.data, pattern, ...)
}
\arguments{
\item{.data}{\code{list}}

\item{pattern}{\code{character}. The regex pattern to match the name of the members}

\item{...}{Additional parameters to pass to \code{grep}}
}
\description{
Select members of a list that match given regex pattern
}
\examples{
\dontrun{
x <- list(p1 = list(type="A",score=list(c1=10,c2=8)),
       p2 = list(type="B",score=list(c1=9,c2=9)),
       p3 = list(type="B",score=list(c1=9,c2=7)))
list.match(x,"p[12]")
list.match(x,"3")
}
}

