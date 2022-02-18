# load packages ---
library(shiny)
library(palmerpenguins)
library(tidyverse)
library(DT)

# user interface ---
ui <- fluidPage(
  
  # app title ---
  tags$h1("Camila's MEDS practice app"),
  # OR
  #h1("Camila's MEDS practice app"),
  
  
  # app subtitle ---
  p(strong("Playing and having fun with shiny")),
  
  
  # body mass silider input ---
  sliderInput(inputId = "body_mass",
              label = "Select a range of body masses (g):",
              min = 2700,
              max = 6300,
              value = c(3000, 4000)), ## starting values
  
  # body mass output ---
  plotOutput(outputId = "body_mass_scatterplot",
             ),
  
  # DT table input ---
  DT::dataTableOutput("mytable")
  
)

# break ---------



# server instructions ---
server <- function(input, output){
  
  # filter body masses ---
  body_mass_df <- reactive({
    
    penguins %>% 
      filter(body_mass_g %in% c(input$body_mass[1]:input$body_mass[2]))
  })
  
  # render scatterplot
  
  output$body_mass_scatterplot <- renderPlot({
    
    # code to generate scatterolot here
    
    ggplot(na.omit(body_mass_df()), ## follow DF with parenthesis becasue it is reactive.
           aes(x = flipper_length_mm,
               y = bill_length_mm,
               color = species,
               shape = species))+
      geom_point(size = 3)+
      scale_color_manual(values = c("Adelie" = "#FEA346", 
                                    "Chinstrap" = "#B251F1",
                                    "Gentoo" = "#4BA4A4"))+
      scale_shape_manual(values = c("Adelie" = 19, 
                                    "Chinstrap" = 17,
                                    "Gentoo" = 15
      ))+
      labs(x = "Flipper length (mm)",
           y = "Bill lenght (mm)",
           color = "Penguin Species",
           shape = "Penguin Species")
    
  })
  
  # DT table output ---
  output$mytable <-  DT::renderDataTable({
    
    # DT::datatable(penguins, 
    #               options = list(lengthMenu = c(5, 30, 50), 
    #                              pageLength = 5),
    #               caption = 'Table 1: This is a simple caption for the table.')
    
    
    DT::datatable(penguins,
                  options = list(pageLength = 5),
                  caption = tags$caption(
                    style = 'caption-side: top; text-align: left;',
                    'Table 1: ', tags$em('Size measurements for adult foraging penguins near Palmer Station, Antarctica')))
    
    
  })
  
}

# combine UI & server into an app ---
shinyApp(ui = ui, server = server)




