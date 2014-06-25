context("list.sort")

test_that("list.sort", {

  # simple list
  x <- list(p1 = list(type="A",score=list(c1=10,c2=8)),
    p2 = list(type="B",score=list(c1=9,c2=9)),
    p3 = list(type="B",score=list(c1=9,c2=7)))

  expect_identical(list.sort(x,type,desc(score$c2)),x[c(1,2,3)])
  expect_identical(list.sort(x,min(score$c1,score$c2)),x[c(3,1,2)])

  # list of vectors
  x <- list(a=c(x=1,y=2),b=c(x=3,y=4))
  expect_identical(list.sort(x,sum(.)),x[c(1,2)])
})