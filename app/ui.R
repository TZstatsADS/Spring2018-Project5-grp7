shinyUI(
  dashboardPage(skin = "red",
    dashboardHeader(title="What shall we cook tonight?",titleWidth = 400),

    dashboardSidebar(width = 240,collapsed=TRUE,
      sidebarMenu(
        menuItem("Introduction",tabName = "Introduction",icon=icon("car"),startExpanded = TRUE),
        menuItem("Exploratory Data Analysis", tabName = "distribution_part", icon = icon("braille"),
                 menuSubItem("General Information",tabName = "whole_data_hist"),
                 menuSubItem("Word Cloud", tabName = "word_cloud")
                 ),
        menuItem("What to cook", tabName = "ingre_part", icon = icon("th")),
        menuItem("Model Comparsion",tabName = "model_comp",icon=icon("cog"))
        )
      ),
    
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
                fluidPage(theme="mystyle.css",
                          div(id="canvas",
                          div(class="myContent",
                              br(),br(),
                              h2("Project summary",align="center"),
                              h1("Food is an innate part of any culture or region. Every cuisine has some unique ingredients or some ingredients that are used in almost all of its dishes. If you visit Korea, the markets would be sprawled with kimchi and the smell of squids. The colourful and aromatic spice markets of India indicate the natural use of diverse spices in the Indian cooking.",align="justify"),
                              h1("In this project, we predict the category of a dish's cuisine given a list of its ingredients. We are using Yummly's data which is arranged by Cuisine, dish ID, and its ingredients.We started off with 6849 ingredients, and used the bag-of-words model to reduce the number of ingredients to 2000. We have divided this project into two parts. The first part is to use different algorithms (Random Forests, XGBoost, SVM, Logistic Regression, Decision Tree, KNN) to predict the category of a dish, and aim at improving the accuracy of the prediction. The second part is building an R Shiny app for exploratory data analysis, as well as recommend the cuisine and other related cuisines given a set of ingredients. We aim to combine and use the knowledge from other projects in this course, and build a product that has high functionality and usability.",align="justify")
                              )
                            )
                          )
        ),
        tabItem("model_comp",
                h2("Model Comparison:"),
                br(),
                tags$img(height = 360, src = "model.png"),align="center"
        ),
        tabItem("whole_data_hist",
                br(),
                plotOutput("hist_wholedata"),
                br(),
                h3(textOutput("hist_result"))
        ),
        tabItem("word_cloud",
                sidebarLayout(
                  sidebarPanel(
                    selectInput("selection", "Choose a cuisine:",choices = cuisine_type),
                    sliderInput("threshold",label="Threshold for amount of ingredients",min=0,max=300,value=100),
                    checkboxInput("specific_ingre","What's special?",value=FALSE)
                    ),
                  mainPanel(
                    wordcloud2Output("wordcloud2",width = "100%", height = "480px")
                  )
                  )
        ),
        tabItem("ingre_part",
          fluidRow(
            sidebarPanel(width=100,
              div(id="diy",
                  h3(helpText("choose the ingredients you have, we will make the best choice of cuisine for you.")),
                  selectInput("check_ingre",h2("Put in your ingredients:"),ingre2000,multiple = TRUE),
                  checkboxInput("check_cb1", h3(helpText("Want more than 1 recommendation")), value = T),
                  actionButton("buttom_go","Go!")
              )
              )
            ),
          fluidRow(
            mainPanel(
                     h3(textOutput("model_result"),align="center")
            )
          )
        )
        )
      )
    )
)

