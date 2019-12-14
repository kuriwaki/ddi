test_that("ddc formula in simplest form works", {
  expect_equal(ddc(0.10, 0.12, 1000, 100),
               (0.12 - 0.10) / (sqrt(0.10*(1 - 0.10))*sqrt((1000 - 100) / 100)))

  one_minus_f <- 1 - (100/1000)
  A_cv <- sqrt(1 + (2^2 / one_minus_f))
  expect_equal(ddc(0.10, 0.12, 1000, 100, cv = 2),
               (1/A_cv) * (0.12 - 0.10) / (sqrt(0.10*(1 - 0.10))*sqrt((1000 - 100) / 100)))
})
