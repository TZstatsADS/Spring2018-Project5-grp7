library(shiny)
library(shinydashboard)
library(d3heatmap)
library(bubbles)
library(slam)
library(NLP)
library(tm)
library(RColorBrewer)
library(wordcloud2)
library(ggplot2)
# Define UI for application that draws a histogram
shinyUI(
  dashboardPage(skin = "red",
    dashboardHeader(title="What's cooking",
                    dropdownMenuOutput("messageMenu")),
    dashboardSidebar(width = 200,
      sidebarMenu(
        menuItem("Introduction",tabName = "Introduction",icon=icon("car"),startExpanded = TRUE),
        menuItem("Cuisine Distribution", tabName = "distribution_part", icon = icon("braille"),
                 menuSubItem("General Information",tabName = "whole_data_hist"),
                 menuSubItem("Word Cloud", tabName = "word_cloud")),
        # sidebarSearchForm(textId = "searchText", buttonId = "searchButton",label = "Search..."),
        menuItem("Model Comparsion",tabName = "model_comp",icon=icon("cog")),
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
        tabItem("Introduction",
                h2("Project summary:"),
                br(),
                fluidRow(tags$img(height = 280, src = "cooking.png"),align="center"),
                br(),
                fluidRow(column(12,
                                h4("Food is an innate part of any culture or region. Every cuisine has some unique ingredients or some ingredients that are used in almost all of its dishes. If you visit Korea, the markets would be sprawled with kimchi and the smell of squids. The colourful and aromatic spice markets of India indicate the natural use of diverse spices in the Indian cooking."),align= "justify"),
                         column(12,
                                h4("In this project, we predict the category of a dish's cuisine given a list of its ingredients. We are using Yummly's data which is arranged by Cuisine, dish ID, and its ingredients.We started off with 6849 ingredients, and used the bag-of-words model to reduce the number of ingredients to 2000. We have divided this project into two parts. The first part is to use different algorithms (Random Forests, XGBoost,SVM, Logistic Regression, Decision Tree, KNN) to predict the category of a dish, and aim at improving the accuracy the prediction. The second part is building an R Shiny app for exploratory data analysis, as well as recommend the cuisine and other related cuisines given a set of a ingredients. We aim to combine and use the knowledge from other projects in this course, and build a product that has high functionality and usability."),align="justify")
                         )
        ),
        tabItem("model_comp",
                h2("Model Comparison:"),
                br(),
                fluidRow(tags$img(height = 360, src = "model.png"),align="center")
        ),
        tabItem("whole_data_hist",
                plotOutput("hist_wholedata")
                ),
        tabItem("word_cloud",
                sidebarLayout(
                  sidebarPanel(
                    selectInput("selection", "Choose a cuisine:",choices = cuisine_type),
                    sliderInput("threshold",label="Threshold for amount of ingredients",min=0,max=300,value=100),
                    checkboxInput("specific_ingre","What's special?",value=FALSE)
                  ),
                  mainPanel(
                    wordcloud2Output("wordcloud2",width = "100%", height = "500px")
                    )
                  )
                ),

        tabItem("model_part",
          fluidRow(
            sidebarPanel(width=100,
              div(id="diy",
                  helpText("choose the ingredients you have, we will make the best choice of cuisine for you."),
                  selectInput("check_ingre","What ingredients you have:",colnames(info_AllCuisine),multiple=TRUE),
                  checkboxInput("check_cb1", c("I wanna more than 1 recommendation(I can buy more new ingredients)"), value = T),
                  actionButton("buttom_go","Go!")
              ),
              div(id = "action",
                  actionButton("no_ingredient", "Clear ALL")
                  )
              )
            ),
          fluidRow(
            mainPanel(
              h4(textOutput("model_result"))
            )
          )
        )
      )
    )
  )
)

