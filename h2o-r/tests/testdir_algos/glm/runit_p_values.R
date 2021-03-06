test.GLM.nonnegative <- function() {
  Log.info("Importing prostate.csv data...\n")
  prostate.hex = h2o.uploadFile(locate("smalldata/logreg/prostate.csv"), "prostate.hex")
  prostate.R = as.data.frame(prostate.hex)
  prostate.sum = summary(prostate.hex)
  print(prostate.sum)  
  prostate.data = read.csv(locate("smalldata/logreg/prostate.csv"), header = TRUE)    
  myY = 2   
  myX = 3:9  
  Log.info(cat("H2O GLM (binomial) with parameters:\nX:", myX, "\nY:", myY, "\n"))
  prostate.glm.h2o = h2o.glm(y = myY, x = myX, training_frame = prostate.hex, family = "binomial", nfolds = 10, alpha = 0.5, compute_p_values=TRUE,standardize=FALSE, lambda = 0)
  prostate.glm.R = glm(data=prostate.R,CAPSULE ~ . - ID, family=binomial)
  print(prostate.glm.h2o)
  coefs.h2o = prostate.glm.h2o@model$coefficients_table[,2:5]        
  coefs.R = summary(prostate.glm.R)$coefficients[,1:4]
  print(cbind(coefs.R,coefs.h2o))
  diff = abs(coefs.h2o - coefs.R)
  print(diff)
  checkTrue(max(diff) < 1e-3, "p-values do not match")
}
doTest("GLM Test: Prostate", test.GLM.nonnegative)