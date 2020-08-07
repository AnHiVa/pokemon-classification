#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    library(tidyverse)
    library(caret)
    df <- read_csv('../pokedex_(Update_05.20).csv')
    
    # clean data for analisis 
    df_small <- df %>%
        select(status,hp, attack,
               defense, sp_attack, sp_defense,
               speed,base_experience) %>%
        mutate(status = as.factor(status)) %>%
        group_by(status) %>%
        mutate( base_experience = replace_na(base_experience, 20))
    
    
    set.seed(745) #For reproducibility 
    
    #Create training and testing sets
    dset <- createDataPartition(y = df_small$status, p = 0.7, list = FALSE)
    training <- df_small[dset, ]
    
    #random forest
    set.seed(7818) # For reproducibility
    
    model_rf <- randomForest(status~., data = training, localImp = TRUE)
    
    
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
    
    
    output$status <- renderText({
        as.character(modelpred())
    
    })
    
    output$image1 <- renderImage({
        if (as.numeric(modelpred()) == 1) {
            return(list(
                src = 'legendary.png',
                contentType = 'image/png',
                alt = 'legendary'
                ))
        } else if (as.numeric(modelpred()) == 2) {
            return(list(
                src = 'mythical.png',
                contentType = 'image/png',
                alt = 'mythical'
            ))
        } else if (as.numeric(modelpred()) == 3) {
            return(list(
                src = 'normal.png',
                contentType = 'image/png',
                alt = 'normal'
            ))
        } else {
            return(list(
                src = 'sub_legendary.png',
                contentType = 'image/png',
                alt = 'sub_legendary'
            ))
        }
    })

})
