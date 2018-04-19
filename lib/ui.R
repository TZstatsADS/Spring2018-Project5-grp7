library(shiny)
library(shinydashboard)
library(d3heatmap)
# Define UI for application that draws a histogram
shinyUI(
  dashboardPage(skin = "red",
    dashboardHeader(title="What's cooking",
                    dropdownMenuOutput("messageMenu")),
    dashboardSidebar(width = 200,
      sidebarMenu(
        menuItem("Cuisine Distribution", tabName = "distribution_part", icon = icon("braille"),startExpanded = TRUE,
                 menuSubItem("Heat Map", tabName = "heat_map"),
                 menuSubItem("Top N ingredients", tabName = "top_n_ingredients")),
        # sidebarSearchForm(textId = "searchText", buttonId = "searchButton",label = "Search..."),
        menuItem("Let's decide what to cook!", tabName = "model_part", icon = icon("th")),
        menuItem("Source code", icon = icon("file-code-o"), 
                 href = "https://github.com/xxxxxxxx")
      )),
    dashboardBody(
      tags$head(tags$style(HTML('
      .main-header .logo {
                                font-family: "Georgia", Times, "Times New Roman", serif;
                                font-weight: bold;
                                font-size: 24px;
                                }
                                '))),
      tabItems(
        tabItem("heat_map",
                d3heatmapOutput("heat_map", width = "100%",height = 500)
        ),
        tabItem("top_n_ingredients",
                plotOutput("hist1")
                ),
        # tabItem("distribution_part",
        #   # fluidRow(
        #   #   box(
        #   #     width = 8, status = "info", solidHeader = TRUE,
        #   #     title = "Popularity by package (last 5 min)",
        #   #     bubblesOutput("bubbles", width = "100%", height = 600)
        #   #   )
        #   # ),
        #   fluidRow(
        #     box(
        #       # title = "Histogram", status = "primary",
        #       # collapsible = TRUE,collapsed = TRUE,
        #       # d3heatmapOutput("hist1", width = "100%",height = 250)
        #     ),
        #     box(
        #       title = "Pie Chart", status = "primary",
        #       #collapsible = TRUE,collapsed = TRUE,
        #       plotOutput("plot4", height = 250)
        #     )
        #   ),
        #   fluidRow(
        #     box(
        #       title = "Inputs", status = "warning", solidHeader = TRUE,
        #       "Select the cuisine that you are interested in", br(), "Up to 5",
        #       textInput("text", "Text input:")
        #     )
        #   )
        # ),
        tabItem("model_part",
          fluidRow(
            
            sidebarPanel(width=100,
              div(id="facilities",
                  helpText("choose the ingredients you have, we will make the best choice of cuisine for you."),
                  selectInput("check_ingre","What ingredients you have:",list("American", "happy lemon","sad lemon","Chinese", "Italian", "Japanese", "Pizza", "Others"),multiple=TRUE),
                  checkboxInput("check_cb1", c("I wanna more than 1 recommendation(I can buy more new ingredients)"), value = T)
              ),
              div(id = "action",
                  actionButton("no_ingredient", "Clear ALL")
              ))
          ),
          fluidRow(
            mainPanel(
              # p("p creates a paragraph of text."),
              # p("A new p() command starts a new paragraph. Supply a style attribute to change the format of the entire paragraph.", style = "font-family: 'times'; font-si16pt"),
              # strong("strong() makes bold text."),
              # em("em() creates italicized (i.e, emphasized) text."),
              # br(),]
              textOutput("model_result")
            )
          )
        )
      )
    )
  )
)
  # navbarPage("Cusine recommendation",
  #   tabPanel("Cusine Distribution",
  #     div(class="outer",
  #         tags$style(type = "text/css", ".outer {position: fixed; top: 41px; left: 0; right: 0; bottom: 0; overflow: hidden; padding: 0}"),)
  #   ),
  #   
  #   tabPanel(
  #     
  #   )
  # )
  # Application title
  #titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  # sidebarLayout(
  #   sidebarPanel(
  #      sliderInput("bins",
  #                  "Number of bins:",
  #                  min = 1,
  #                  max = 50,
  #                  value = 30)
  #   ),
  #   
  #   # Show a plot of the generated distribution
  #   mainPanel(
  #      plotOutput("distPlot")
  #   )
  # )
