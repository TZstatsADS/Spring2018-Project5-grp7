library(shiny)
library(d3heatmap)

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
