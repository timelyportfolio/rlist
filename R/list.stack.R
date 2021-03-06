#' Stack all list members to construct a \code{data.frame}
#'
#' @param .data \code{list} of \code{vector}s, \code{list}s,
#'    or \code{data.frame}s.
#' @name list.stack
#' @export
#' @examples
#' \dontrun{
#' x <- lapply(1:3, function(i) { list(a=i,b=i^2) })
#' list.stack(x)
#'
#' x <- lapply(1:3, function(i) { list(a=i,b=i^2,c=letters[i])})
#' list.stack(x)
#'
#' x <- lapply(1:3, function(i) { data.frame(a=i,b=i^2,c=letters[i]) })
#' list.stack(x)
#' }
list.stack <- function(.data) {
  dt <- data.table::rbindlist(.data)
  class(dt) <- "data.frame"
  dt
}
