

#LIBRARY -- 
library(tidyverse)

#Loading CSV:s exportedfrom mySQL -- 

ch_tbl <- read_csv("custchurn.csv")

top10_tbl <- read_csv("toptencust.csv")

#GGplot highrisk.vs loyal 
ch_tbl %>% 
  ggplot(aes(customer_status,total_customers,fill=customer_status))+
  geom_col()+
  labs(y="Total customers",x=NULL)

#Numbers table-- 
ch_tbl

#GGplot barchart -- 
top10_tbl %>%
  ggplot(aes(revenue,reorder(fullname, revenue),fill=revenue)) +  
  geom_col()+
  labs(x="Revenue(USD)",y="Name")+
  theme(legend.position="none")

#Table --
top10_tbl

         