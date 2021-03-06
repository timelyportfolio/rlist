#' Search a list recusively by an expression
#'
#' @param .data \code{list}
#' @param expr a lambda expression with respect to value that returns
#' a single-valued logical vector. In the expression, exact and fuzzy search functions are recommended.
#' @param classes a character vector of class names that restrict the search. By default, the range is unrestricted (\code{ANY}).
#' @param n the maximum number of result results
#' @param unlist \code{logical} Should the result be unlisted?
#' @param envir The environment to evaluate mapping function
#' @name list.search
#' @export
#' @examples
#' \dontrun{
#' # Exact search
#'
#' x <- list(p1 = list(type="A",score=c(c1=9)),
#'        p2 = list(type=c("A","B"),score=c(c1=8,c2=9)),
#'        p3 = list(type=c("B","C"),score=c(c1=9,c2=7)),
#'        p4 = list(type=c("B","C"),score=c(c1=8,c2=NA)))
#'
#' ## Search exact values
#' list.search(x, equal("A", exactly = TRUE))
#' list.search(x, equal(c("A","B"), exactly = TRUE))
#' list.search(x, equal(c(9,7), exactly = TRUE))
#' list.search(x, equal(c(c1=9,c2=7), exactly = TRUE))
#'
#' ## Search all equal values
#' list.search(x, all(equal(9)))
#' list.search(x, all(equal(c(8,9))))
#' list.search(x, all(equal(c(8,9)),na.rm = TRUE))
#'
#' ## Search any equal values
#' list.search(x, any(equal(9)))
#' list.search(x, any(equal(c(8,9))))
#'
#' ## Search all/any included/excluded values
#' list.search(x, equal(9, include = TRUE))
#' list.search(x, all(equal(c(9,10), include = TRUE)))
#' list.search(x, any(equal(c(9,10), include = TRUE)))
#' list.search(x, all(!equal(c(7,9,10), include = TRUE)))
#'
#' # Fuzzy search
#'
#' data <- list(
#'   p1 = list(name="Ken",age=24),
#'   p2 = list(name="Kent",age=26),
#'   p3 = list(name="Sam",age=24),
#'   p4 = list(name="Keynes",age=30),
#'   p5 = list(name="Kwen",age=31)
#' )
#'
#' list.search(data, equal("^K\\w+n$", pattern = TRUE), "character")
#'
#' list.search(data, equal("Ken", dist = 1), "character")
#' list.search(data, equal("Man", dist = 2), "character")
#' list.search(data, !equal("Man", dist = 2), "character")
#'
#' data <- list(
#'   p1 = list(name=c("Ken", "Ren"),age=24),
#'   p2 = list(name=c("Kent", "Potter"),age=26),
#'   p3 = list(name=c("Sam", "Lee"),age=24),
#'   p4 = list(name=c("Keynes", "Bond"),age=30),
#'   p5 = list(name=c("Kwen", "Hu"),age=31))
#'
#' list.search(data, all(equal("Ken", dist = 1)), "character")
#' list.search(data, any(equal("Ken", dist = 1)), "character")
#' list.search(data, all(!equal("Ken", dist = 1)), "character")
#' list.search(data, any(!equal("Ken", dist = 1)), "character")
#' }
list.search <- function(.data, expr, classes = "ANY",
  n = Inf, unlist = FALSE, envir = parent.frame()) {
  l <- lambda(substitute(expr))
  counter <- as.environment(list(i = 0L))
  fun <- list.search.fun
  environment(fun) <- envir
  formals(fun) <- setnames(formals(fun),
    c(".data",".expr",".counter",".n",l$symbols))
  results <- rapply(.data, fun, classes = classes,
    how = if(unlist) "unlist" else "list",
    .expr = l$expr, .counter = counter, .n = n)
  if(!unlist) {
    results <- list.clean(results,
      fun = is.null.or.empty, recursive = TRUE)
  }
  results
}
