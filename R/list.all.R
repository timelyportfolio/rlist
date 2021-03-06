#' Get whether all list members satisfy the given condition
#'
#' @param .data \code{list}
#' @param cond A logical lambda expression
#' @param na.rm logical. If true all \code{NA} values are removed
#' @param envir The environment to evaluate mapping function
#' @name list.all
#' @export
#' @examples
#' \dontrun{
#' x <- list(p1 = list(type="A",score=list(c1=10,c2=8)),
#'        p2 = list(type="B",score=list(c1=9,c2=9)),
#'        p3 = list(type="B",score=list(c1=9,c2=7)))
#' list.all(x,type=="B")
#' list.all(x,mean(unlist(score))>=6)
#' }
list.all <- function(.data,cond,na.rm=FALSE,envir=parent.frame()) {
  all(list.is.internal(.data,substitute(cond),envir),na.rm = na.rm)
}
