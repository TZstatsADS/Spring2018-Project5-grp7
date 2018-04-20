
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  # output$messageMenu <- renderMenu({
  #   # Code to generate each of the messageItems here, in a list. This assumes
  #   # that messageData is a data frame with two columns, 'from' and 'message'.
  #   msgs <- apply(messageData, 1, function(row) {
  #     messageItem(from = row[["from"]], message = row[["message"]])
  #   })
  # 
  #   dropdownMenu(type = "messages", .list = msgs)
  # })
  #output$packagePlot<-renderPlot()
  output$hist_wholedata<-renderPlot({
    reorder_size <- function(x) {
      factor(x, levels = names(sort(table(x),decreasing=TRUE)))
    }
    ggplot(cooking_data)+
      geom_bar(aes(reorder_size(cuisine),fill = cuisine),border = 'white')+
      theme(axis.text.x=element_text(angle=45,hjust=1,vjust=0.5))+
      xlab("Cuisine")
  })
  output$hist_
  output$heat_map<-renderD3heatmap({
    d3heatmap(
      info_AllCusine[,Top5_each_index],scale="row",dendrogram = "none",color="Blues"
    )
  })
  output$model_result <- renderText({ 
    "You best choice is Chinese Cuisine!We also recommend these cuisines for you: XXX,XXX,XXX. Choose the one you prefer. Then you may need to buy these ingredients"
  })
  
  output$hist1<-renderPlot({
    hist(info_AllCusine[1,])
  })
})
