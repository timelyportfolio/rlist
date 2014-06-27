#' Join two lists by single or multiple keys
#' @param x The first list
#' @param y The second list
#' @param xkey An expression that determines the key for list \code{x}
#' @param ykey An expression that determines the key for list \code{y},
#'    same to \code{xkey} if \code{NULL} is taken
#' @param ... The additional parameters passed to \code{merge.data.frame}
#' @param keep.order Should the order of \code{x} be kept?
#' @name list.join
#' @export
#' @examples
#' \dontrun{
#' l1 <- list(p1=list(name="Ken",age=20),
#'        p2=list(name="James",age=21),
#'        p3=list(name="Jenny",age=20))
#' l2 <- list(p1=list(name="Jenny",age=20,type="A"),
#'        p2=list(name="Ken",age=20,type="B"),
#'        p3=list(name="James",age=21,type="A"))
#' list.join(l1,l2,name)
#' list.join(l1,l2,.["name","age"])
#' }
list.join <- function(x,y,xkey,ykey=NULL,...,keep.order=TRUE) {
  xkey <- substitute(xkey)
  ykey <- substitute(ykey)
  if(is.null(xkey) & is.null(ykey)) stop("At least one key should be specified")
  if(is.null(ykey)) ykey <- xkey
  xkeys.list <- list.map(x,data.frame(eval(xkey)))
  ykeys.list <- list.map(y,data.frame(eval(ykey)))
  xkeys.df <- list.rbind(xkeys.list)
  ykeys.df <- list.rbind(ykeys.list)
  if(is.name(xkey)) colnames(xkeys.df) <- as.character(xkey)
  if(is.name(ykey)) colnames(ykeys.df) <- as.character(ykey)
  if(!identical(colnames(xkeys.df),colnames(ykeys.df))) {
    stop("Inconsistent keys")
  }
  xkeys <- cbind(.xi=seq_along(xkeys.list),xkeys.df)
  ykeys <- cbind(.yi=seq_along(ykeys.list),ykeys.df)
  df <- merge.data.frame(xkeys,ykeys,by=colnames(xkeys)[-1],...)
  if(keep.order) df <- df[order(df$.xi),]
  xlist <- x[df$.xi]
  ylist <- y[df$.yi]
  xi <- seq_along(xlist)
  names(xi) <- names(x)[df$.xi]
  result <- lapply(xi,function(i) {
    modifyList(xlist[[i]],ylist[[i]])
  })
  result
}