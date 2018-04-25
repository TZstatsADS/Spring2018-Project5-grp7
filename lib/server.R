
# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
  # output$messageMenu <- renderMenu({
  #   # Code to generate each of the messageItems here, in a list. This assumes
  #   # that messageData is a data frame with two columns, 'from' and 'message'.
  #   msgs <- apply(messageData, 1, function(row) {
  #     messageItem(from = row[["from"]], message = row[["message"]])
  #   })
  # 
  #   dropdownMenu(type = "messages", .list = msgs)
  # })
  output$hist_wholedata<-renderPlot({
    reorder_size <- function(x) {
      factor(x, levels = names(sort(table(x),decreasing=TRUE)))
    }
    ggplot(cooking_data)+
      geom_bar(aes(reorder_size(cuisine),fill = cuisine),border = 'white')+
      theme(axis.text.x=element_text(angle=45,hjust=1,vjust=0.5))+
      xlab("Cuisine")
  })
  

  observeEvent(input$specific_ingre,{
    if(input$specific_ingre==FALSE){
      output$wordcloud2 <- renderWordcloud2({
        wordcloud2(ingre_freq[ingre_freq[,input$selection]>input$threshold,c("names",input$selection)],color="random-light")
      })
    }else{
      output$wordcloud2 <- renderWordcloud2({
        wordcloud2(ingre_freq[ingre_freq$names%in%names(which(colSums(info_AllCuisine_1[!(input$selection==cuisine_type),])==0)),c("names",input$selection)],color="random-dark")
      })
      }
    })
  observeEvent(input$check_cb1,{
    if(input$check_cb1){
      observeEvent(input$buttom_go,{
        output$model_result <- renderText({
          a<-sample(cuisine_type,1)
          b<-sample(cuisine_type,1)
          paste0("Your best choice is ",a,"."," You can also make ",b,".")
          #paste0("You can also make ",b,".")
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
