library(testthat)
context('RCrimeStat')

d <- datasuccess()

test_that("Invalid data", {
  expect_error(verify(length(colnames(x))) == 9)
  expect_error(verify(colnames(x)[1] == "category"))
  expect_error(verify(colnames(x)[2] == "location_type"))
  expect_error(verify(colnames(x)[3] == "location"))
  expect_error(verify(colnames(x)[4] == "context"))
  expect_error(verify(colnames(x)[5] == "outcome_status"))
  expect_error(verify(colnames(x)[6] == "persistent_id"))
  expect_error(verify(colnames(x)[7] == "id"))
  expect_error(verify(colnames(x)[8] == "location_subtype"))
  expect_error(verify(colnames(x)[9] == "month"))
})