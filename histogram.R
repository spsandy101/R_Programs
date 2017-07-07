
### Generate Histogram of random nubers ###

library(shiny)

ui<- fluidPage( sliderInput(inputId = "num",
                          label = "Chose a number",
                          value = 100, min = 1, max = 1000),
                textInput(inputId = "title",
                          label = "Write a title",
                          value = c("Histogram of Random Normal variables")
                ),
                plotOutput("hist"),
                verbatimTextOutput("stats")
)

server<- function(input, output){
  inputData<- reactive({rnorm(input$num)})
  output$hist <- renderPlot({
    hist(inputData(), main = input$title)
  })
  output$stats<- renderPrint({
    summary(inputData())
  })
}

shinyApp(ui=ui, server= server)





#############
# ### Shiny Library ###
# library(shiny)
# 
# ### UI ###
# shinyUI(bootstrapPage(
#   
#   selectInput(inputId = "n_breaks",
#               label = "Number of bins in histogram (approximate):",
#               choices = c(10, 20, 35, 50),
#               selected = 20),
#   
#   checkboxInput(inputId = "individual_obs",
#                 label = strong("Show individual observations"),
#                 value = FALSE),
#   
#   checkboxInput(inputId = "density",
#                 label = strong("Show density estimate"),
#                 value = FALSE),
#   
#   plotOutput(outputId = "main_plot", height = "300px"),
#   
#   # Display this only if the density is shown
#   conditionalPanel(condition = "input.density == true",
#                    sliderInput(inputId = "bw_adjust",
#                                label = "Bandwidth adjustment:",
#                                min = 0.2, max = 2, value = 1, step = 0.2)
#   )
#   
# ))
# 
# 
# ### Server ###
# shinyServer(function(input, output) {
#   
#   output$main_plot <- renderPlot({
#     
#     hist(faithful$eruptions,
#          probability = TRUE,
#          breaks = as.numeric(input$n_breaks),
#          xlab = "Duration (minutes)",
#          main = "Geyser eruption duration")
#     
#     if (input$individual_obs) {
#       rug(faithful$eruptions)
#     }
#     
#     if (input$density) {
#       dens <- density(faithful$eruptions,
#                       adjust = input$bw_adjust)
#       lines(dens, col = "blue")
#     }
#     
#   })
# })
# 
# 
# ### Run App ###
# shinyApp(ui=ui, server= server)
##################