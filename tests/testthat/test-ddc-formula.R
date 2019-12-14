test_that("ddc formula in simplest form works", {
  expect_equal(ddc(0.10, 0.12, 1000, 100),
               (0.12 - 0.10) / (sqrt(0.10*(1 - 0.10))*sqrt((1000 - 100) / 1000)))
})
