#' Compare two values and test whether they are equal at certain degree
#' @details
#' \code{equal()} tests if two values are equal in certain sense. By default it
#' performs atomic equality test (\code{==}) between two atomic vectors with
#' the same mode and length unless any of the additional parameters is specified.
#'
#' \code{exactly = }, \code{include = }, \code{pattern = }, and \code{dist = }
#' are mutually exlcusive and the former one always has higher priority than
#' the latter one, that is, if \code{exactly = TRUE} is specified then the last
#' three arguments will be ignored; or if \code{include = TRUE} is specified
#' then the last two arguments will be ignored, etc.
#' @param x target value
#' @param y source value (can be ignored in \code{list.search} expression)
#' @param exactly \code{TRUE} to test if \code{x} and \code{y} are
#' exactly identical. \code{...} will be passed to \code{identical}.
#' @param include \code{TRUE} to test if \code{x} included in \code{y}.
#' @param pattern \code{TRUE} to indicate \code{x} is a regular expression
#' pattern and test if \code{y} matches that pattern.
#' \code{...} will be passed to \code{grepl}.
#' @param dist \code{integer} to indicate the maximum string distance
#' in tolerance and test if \code{x} is close to \code{y} in the distance.
#' \code{...} will be passed to \code{stringdist::stringdist}.
#' @param ... additional parameters
#' @return \code{logical}
#' @export
equal <- function(x, y = get(".data", envir = parent.frame(), inherits = FALSE),
  exactly = FALSE, include = FALSE, pattern = FALSE, dist = NA_integer_, ...) {
  if(exactly) identical(x,y,...)
  else if(include) {
    if(mode(x) == mode(y)) x %in% y
    else FALSE
  }
  else if(pattern) grepl(x, y, ...)
  else if(!is.na(dist)) stringdist::stringdist(x,y,...) <= dist
  else {
    if(mode(x) == mode(y) && length(x) == length(y)) x == y
    else FALSE
  }
}
