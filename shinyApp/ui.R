
library(shiny)


shinyUI(fluidPage(

    # Application title
    titlePanel(h1("Pokémon Group Prediction")),

    # Sidebar with a slider input for Pokémon stats
    sidebarLayout(
        sidebarPanel(
            h2("Adjust stats to predict a Pokémon's group"),
            em('Just move the sliders'),
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
        

        # Outputs group and image
        mainPanel(
            h1('¿Normal, Sub Legendary, Mythical or Legendary Pokémon?'),
            h2(textOutput('status')),
            imageOutput('image1')
        )
    )
))
