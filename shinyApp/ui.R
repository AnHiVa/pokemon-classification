#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Pokémon Status Prediction"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("hp",
                        "HP base stat:",
                        min = 1,
                        max = 255,
                        value = 100),
            sliderInput("attack",
                        "Attack base stat:",
                        min = 1,
                        max = 255,
                        value = 100),
            sliderInput("defense",
                        "Defence base stat:",
                        min = 1,
                        max = 255,
                        value = 100),
            sliderInput("sp_attack",
                        "Special Attack base stat:",
                        min = 1,
                        max = 255,
                        value = 100),
            sliderInput("sp_defense",
                        "Special Defence base stat:",
                        min = 1,
                        max = 255,
                        value = 100),
            sliderInput("speed",
                        "Speed base stat:",
                        min = 1,
                        max = 255,
                        value = 100),
            sliderInput("base_experience",
                        "Base Experience:",
                        min = 1,
                        max = 608,
                        value = 100)
        ),
        

        # Show a plot of the generated distribution
        mainPanel(
            h1('¿Normal, Sub Legendary, Mythical or Legendary?'),
            h2(textOutput('status')),
            imageOutput('image1')
        )
    )
))
