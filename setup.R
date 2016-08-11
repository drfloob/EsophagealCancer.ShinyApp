# with help from the analysis done here: http://www.ats.ucla.edu/stat/r/seminars/ggplot2_intro/ggplot2_intro.Rhtml

library(datasets)
data(esoph)

logitModel <- glm(cbind(ncases, ncontrols) ~ as.numeric(agegp) + 
                  as.numeric(alcgp) + as.numeric(tobgp),
              data=esoph, family=binomial)

esoph$.xb <- predict(logitModel, esoph)
esoph$.devr <- residuals(logitModel, type="deviance")
esoph$.pred <- predict(logitModel, esoph, type="response")

save(esoph, logitModel, file="./data/DataAndModel.RData")
