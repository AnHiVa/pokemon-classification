
library(shiny)

#Source helper functions
source('helpers.R')

# Define server logic required to predict the Pokémon group
shinyServer(function(input, output) {
    
    
    #Get user data
    modelpred <- reactive({
        
        hpInput <- input$hp
        attackInput <- input$attack
        defenseInput <- input$defense
        sp_attackInput <- input$sp_attack
        sp_defenseInput <- input$sp_defense
        speedInput <- input$speed
        expInput <- input$base_experience
        
        #create df
        userdf <- tibble(hp = hpInput,
                         attack = attackInput,
                         defense = defenseInput,
                         sp_attack = sp_attackInput,
                         sp_defense = sp_defenseInput,
                         speed = speedInput,
                         base_experience = expInput)
        predict(model_rf, userdf)
    })
    
    # Output group predicted
    output$status <- renderText({
        as.character(modelpred())
    
    })
    # output image
    output$image1 <- renderImage({
        if (as.numeric(modelpred()) == 1) {
            return(list(
                src = 'images/legendary.png',
                contentType = 'image/png',
                alt = 'legendary'
                ))
        } else if (as.numeric(modelpred()) == 2) {
            return(list(
                src = 'images/mythical.png',
                contentType = 'image/png',
                alt = 'mythical'
            ))
        } else if (as.numeric(modelpred()) == 3) {
            return(list(
                src = 'images/normal.png',
                contentType = 'image/png',
                alt = 'normal'
            ))
        } else {
            return(list(
                src = 'images/sub_legendary.png',
                width = 640,
                height = 480,
                contentType = 'image/png',
                alt = 'sub_legendary'
            ))
        }
    })

})
