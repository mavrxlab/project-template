# Power analysis
library(pwr)

# A priori power analysis
calculate_sample_size <- function(
  effect_size,
  power = 0.80,
  alpha = 0.05,
  test_type = c("t", "f", "r", "anova")
) {
  
  test_type <- match.arg(test_type)
  
  power_analysis <- switch(test_type,
    "t" = pwr.t.test(d = effect_size, power = power, sig.level = alpha),
    "f" = pwr.f2.test(f2 = effect_size, power = power, sig.level = alpha),
    "r" = pwr.r.test(r = effect_size, power = power, sig.level = alpha),
    "anova" = pwr.anova.test(f = effect_size, power = power, sig.level = alpha)
  )
  
  return(power_analysis)
}

# Post-hoc power analysis
calculate_achieved_power <- function(
  effect_size,
  n,
  alpha = 0.05,
  test_type = c("t", "f", "r", "anova")
) {
  
  test_type <- match.arg(test_type)
  
  achieved_power <- switch(test_type,
    "t" = pwr.t.test(d = effect_size, n = n, sig.level = alpha),
    "f" = pwr.f2.test(f2 = effect_size, n = n, sig.level = alpha),
    "r" = pwr.r.test(r = effect_size, n = n, sig.level = alpha),
    "anova" = pwr.anova.test(f = effect_size, n = n, sig.level = alpha)
  )
  
  return(achieved_power)
}