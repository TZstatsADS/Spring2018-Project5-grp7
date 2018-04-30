library(shiny)
library(shinydashboard)
library(slam)
library(RColorBrewer)
library(wordcloud2)
library(ggplot2)
library(Matrix)
library(glmnet)
load("./data/cuisine_type.RData")
load("./data/hist.RData")
#correlation
load("./data/df.RData")
## for wordcloud
load("./data/ingre_freq.RData")
## specific ingredients for each cuisine
load("./data/info_AllCuisine_1.RData")
load("./data/logistic_model_shiny_update.RData")
load("./data/ingre2000.RData")

########


# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
  output$hist_wholedata<-renderPlot({
    # reorder_size <- function(x) {
    #   factor(x, levels = names(sort(table(x),decreasing=TRUE)))
    # }
    ggplot(hist)+
      geom_col(aes(x=Var1,y=Freq,fill=Var1))+
      #geom_bar(aes(reorder_size(cuisine),fill = cuisine))+
      theme(axis.text.x=element_text(angle=45,hjust=1,vjust=0.5))+
      xlab("Cuisine")
  })

  output$hist_result<- renderText({
    "(1) 20 cuisines in total; (2)Italian has most dishes in our dataset; (3)Imbalanced classes"
  })

  #wd<-eventReactive(input$selection)
  observeEvent(input$specific_ingre,{
    if(input$specific_ingre==FALSE){
      output$wordcloud2 <- renderWordcloud2({
        wordcloud2(ingre_freq[ingre_freq[,input$selection]>input$threshold,c("names",input$selection)],color="random-light")
      })
    }else{
      output$wordcloud2 <- renderWordcloud2({
        a<-info_AllCuisine_1[!(input$selection==cuisine_type),]
        b<-colnames(a)[which(colSums(a)==0)]
        whichrow<-ingre_freq$names %in% b
        wordcloud2(ingre_freq[whichrow,c("names",input$selection)],color="random-dark")
      })
      }
    })


 result_txt<-eventReactive(input$buttom_go, {
    userdiy<-ifelse(ingre2000%in%input$check_ingre,1,0)
    userdiy<-c(1,userdiy)
    userdiy_sparse <- t(as(userdiy, "sparseMatrix"))
    lmd<-fit$lambda.min
    pred <- predict(fit, newx=userdiy_sparse, type="class", s=lmd)
 })
 observeEvent(input$check_cb1,{
   if(input$check_cb1){
     output$model_result<-renderText({
       a<-result_txt()
       b<-df[df[,1]==a,c(2,3)]
       paste0("Your best choice is ",a,"."," You can also make ",b[1]," and ",b[2])
     })
   }
   else{
     output$model_result<-renderText({
       a<-result_txt()
       paste0("Your best choice is ",a,".")
     })
   }
 })

             




  # observeEvent(input$check_ingre,{
  #   if(!is.null(input$check_ingre)){
  #     observeEvent(input$check_cb1,{
  #       if(input$check_cb1){
  #         output$model_result <- renderText({
  #           a<-result_txt()
  #           b<-df[df[,1]==a,c(2,3)]
  #           paste0("Your best choice is ",a,"."," You can also make ",b[1]," and ",b[2])
  #         })
  #       }else{
  #         output$model_result <- renderText({
  #           a<-result_txt()
  #           paste0("Your best choice is ",a,".")
  #         })
  #       }
  #     })
  #   }else{
  #     output$model_result<-renderText({
  #       paste0("0")
  #     })
  #   }
  # })
# 
#   observeEvent(input$check_ingre,{
#     userdiy<-ifelse(ingre2000%in%input$check_ingre,1,0)
#     userdiy<-c(1,userdiy)
#     userdiy_sparse <- t(as(userdiy, "sparseMatrix"))
#     pred <- predict(fit, userdiy_sparse, type="class", s=fit$lambda.min)
#   })
#   observeEvent(input$check_cb1,{
#     if(input$check_cb1){
#       observeEvent(input$buttom_go,{
#         output$model_result <- renderText({
#           a<-result_txt()
#           b<-df[df[,1]==a,c(2,3)]
#           paste0("Your best choice is ",a,"."," You can also make ",b[1]," and ",b[2])
#         })
#       })
#     }else{
#       observeEvent(input$buttom_go,{
#         output$model_result <- renderText({
#           a<-result_txt()
#           paste0("Your best choice is ",a)
#         })
#       })
#     }
#   })

  
  
  # 
  # output$model_result<-renderText({
  #   a<-result_txt()
  #   paste0("Your best choice is ",a)
  # })
  
  # observeEvent(input$check_ingre,{
  #   if(is.null(input$check_ingre)){
  #     output$model_result<-renderText({
  #       NULL
  #     })
  #   }
  # })
  
})


