#' Remove members from a list by index or name
#'
#' @param x The list
#' @param range A numeric vector of indices or
#' a character vector of names to remove from \code{x}
#' @name list.remove
#' @export
#' @examples
#' \dontrun{
#' x <- list(p1 = list(type="A",score=list(c1=10,c2=8)),
#'        p2 = list(type="B",score=list(c1=9,c2=9)),
#'        p3 = list(type="B",score=list(c1=9,c2=7)))
#' list.remove(x,"p1")
#' list.remove(x,c(1,2))
#' }
list.remove <- function(x,range=integer()) {
  if(is.logical(range)) {
    x[!range]
  } else if(is.numeric(range)) {
    x[-range]
  } else if(is.character(range)) {
    names <- names(x)
    m <- vapply(range,`==`,logical(length(x)),names)
    selector <- apply(m,1,any)
    x[!selector]
  }
}