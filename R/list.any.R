#' Get whether any list member satisfies the given condition
#'
#' @param ... Parameters passed to \code{list.if}
#' @param na.rm logical. If true all \code{NA} values are removed
#' @name list.any
#' @export
#' @examples
#' \dontrun{
#' x <- list(p1 = list(type="A",score=list(c1=10,c2=8)),
#'        p2 = list(type="B",score=list(c1=9,c2=9)),
#'        p3 = list(type="B",score=list(c1=9,c2=7)))
#' list.any(x,type=="B")
#' list.any(x,mean(unlist(score))>=6)
#' }
list.any <- function(...,na.rm=FALSE) {
  any(list.if(...),na.rm = na.rm)
}