group1<- c(2,3,7,2,6)
group2<- c(10,8,7,5,10)
group3<- c(10,13,14,13,15)

combined_groups<- data.frame(cbind(group1, group2, group3))
summary(combined_groups)

stacked_groups<- stack(combined_groups)
stacked_groups

anova_results<- aov(values~ind, data = stacked_groups)
summary(anova_results)