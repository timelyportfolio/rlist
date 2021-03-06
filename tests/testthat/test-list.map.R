context("list mapping")

test_that("list.map", {

  # simple list
  x <- list(p1 = list(type="A",score=list(c1=10,c2=8)),
    p2 = list(type="B",score=list(c1=9,c2=9)),
    p3 = list(type="B",score=list(c1=9,c2=7)))

  expect_identical(list.map(x,score$c1),list(p1=10,p2=9,p3=9))

  # list of vectors
  x <- list(a=c(x=1,y=2),b=c(x=3,y=4))
  expect_identical(list.map(x,sum(.)),list(a=3,b=7))

  lapply(1:3,function(i) list.map(x,sum(.)+i))
})

test_that("list.mapv", {
  # simple list
  x <- list(p1 = list(type="A",score=list(c1=10,c2=8)),
    p2 = list(type="B",score=list(c1=9,c2=9)),
    p3 = list(type="B",score=list(c1=9,c2=7)))

  expect_equal(list.mapv(x,score$c1),c(p1=10,p2=9,p3=9))
  expect_equal(list.mapv(x,x -> sum(unlist(x$score))),c(p1=18,p2=18,p3=16))

  # list of vectors
  x <- list(a=c(x=1,y=2),b=c(x=3,y=4))
  expect_equal(list.mapv(x,sum(.)),c(a=3,b=7))

  lapply(1:3,function(i) list.mapv(x,sum(.)+i))
})

test_that("list.maps", {
  l1 <- list(p1=list(x=1,y=2), p2=list(x=3,y=4), p3=list(x=1,y=3))
  l2 <- list(2,3,5)
  expect_equal(list.maps(a$x*b+a$y,a=l1,b=l2),list(p1=4,p2=13,p3=8))
})
