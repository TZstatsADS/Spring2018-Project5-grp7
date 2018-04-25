
# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
  output$hist_wholedata<-renderPlot({
    reorder_size <- function(x) {
      factor(x, levels = names(sort(table(x),decreasing=TRUE)))
    }
    ggplot(cooking_data)+
      geom_bar(aes(reorder_size(cuisine),fill = cuisine),border = 'white')+
      theme(axis.text.x=element_text(angle=45,hjust=1,vjust=0.5))+
      xlab("Cuisine")
  })

  output$hist_result<- renderText({
    "(1) 20 cuisines in total; (2)Italian has most dishes in our dataset; (3)Imbalanced classes"
  })

  observeEvent(input$specific_ingre,{
    if(input$specific_ingre==FALSE){
      output$wordcloud2 <- renderWordcloud2({
        wordcloud2(ingre_freq[ingre_freq[,input$selection]>input$threshold,c("names",input$selection)],color="random-light")
      })
    }else{
      output$wordcloud2 <- renderWordcloud2({
        a<-info_AllCuisine_1[!(input$selection==cuisine_type),]
        b<-which(colSums(a)==0)
        whichrow<-ingre_freq$names%in%names(b)
        wordcloud2(ingre_freq[whichrow,c("names",input$selection)],color="random-dark")
      })
      }
    })

  observeEvent(input$check_cb1,{
    if(input$check_cb1){
      observeEvent(input$buttom_go,{
        output$model_result <- renderText({
          a<-sample(cuisine_type,1)
          b<-df[df[,1]==a,c(2,3)]
          paste0("Your best choice is ",a,"."," You can also make ",b[1]," and ",b[2])
        })
      })
    }else{
      observeEvent(input$buttom_go,{
        output$model_result <- renderText({
          a<-sample(cuisine_type,1)
          paste0("Your best choice is ",a)
        })
      })
    }
  })

})
