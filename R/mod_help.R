#' help UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList includeMarkdown fluidPage column div br tabPanel
#'
mod_help_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      column(width = 12),
      column(
        width = 12,
        div(
          style = "padding: 20px;",
          div(
            style = "text-align: center; margin-bottom: 25px; padding-bottom: 15px; border-bottom: 2px solid #17a2b8;",
            tags$h2("Help Documentation", style = "color: #17a2b8; margin-bottom: 10px;"),
            tags$p("Click a module to expand its help section.",
              style = "color: #666; font-size: 16px;"
            )
          )
        ),
        box(
          title = "Input Data", id = "Inputs_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
          "This tab allows users to upload and manage input data for analysis.",
          br(), br(),
          tabsetPanel(
            id = "Inputs_tabset",
            tabPanel("Parameters description",
              value = "Inputs_par", br(),
              includeMarkdown(system.file("help_files/Inputs_par.Rmd", package = "viewpoly"))
            ),
            tabPanel("Results description",
              value = "Inputs_results", br(),
              includeMarkdown(system.file("help_files/Inputs_res.Rmd", package = "viewpoly"))
            ),
            tabPanel("How to cite",
              value = "Inputs_cite", br(),
              includeMarkdown(system.file("help_files/Inputs_cite.Rmd", package = "viewpoly"))
            )
          )
        ),
        box(
          title = "ViewQTL", id = "QTL_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
          "This tab allows users to upload and manage input data for analysis.",
          br(), br(),
          tabsetPanel(
            id = "QTL_tabset",
            tabPanel("Parameters description",
              value = "QTL_par", br(),
              includeMarkdown(system.file("help_files/QTL_par.Rmd", package = "viewpoly"))
            ),
            tabPanel("Results description",
              value = "QTL_results", br(),
              includeMarkdown(system.file("help_files/QTL_res.Rmd", package = "viewpoly"))
            ),
            tabPanel("How to cite",
              value = "QTL_cite", br(),
              includeMarkdown(system.file("help_files/QTL_cite.Rmd", package = "viewpoly"))
            )
          )
        ),
        box(
          title = "ViewGenome", id = "Genome_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
          "This tab allows users to upload and manage input data for analysis.",
          br(), br(),
          tabsetPanel(
            id = "Genome_tabset",
            tabPanel("Parameters description",
              value = "Genome_par", br(),
              includeMarkdown(system.file("help_files/Genome_par.Rmd", package = "viewpoly"))
            ),
            tabPanel("Results description",
              value = "Genome_results", br(),
              includeMarkdown(system.file("help_files/Genome_res.Rmd", package = "viewpoly"))
            ),
            tabPanel("How to cite",
              value = "Genome_cite", br(),
              includeMarkdown(system.file("help_files/Genome_cite.Rmd", package = "viewpoly"))
            )
          )
        ),
        box(
          title = "ViewMap", id = "Map_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
          "This tab allows users to upload and manage input data for analysis.",
          br(), br(),
          tabsetPanel(
            id = "Map_tabset",
            tabPanel("Parameters description",
              value = "Map_par", br(),
              includeMarkdown(system.file("help_files/Map_par.Rmd", package = "viewpoly"))
            ),
            tabPanel("Results description",
              value = "Map_results", br(),
              includeMarkdown(system.file("help_files/Map_res.Rmd", package = "viewpoly"))
            ),
            tabPanel("How to cite",
              value = "Map_cite", br(),
              includeMarkdown(system.file("help_files/Map_cite.Rmd", package = "viewpoly"))
            )
          )
        ),
        box(
          title = "HIDECAN", id = "Hidecan_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
          "This tab allows users to upload and manage input data for analysis.",
          br(), br(),
          tabsetPanel(
            id = "Hidecan_tabset",
            tabPanel("Parameters description",
              value = "Hidecan_par", br(),
              includeMarkdown(system.file("help_files/Hidecan_par.Rmd", package = "viewpoly"))
            ),
            tabPanel("Results description",
              value = "Hidecan_results", br(),
              includeMarkdown(system.file("help_files/Hidecan_res.Rmd", package = "viewpoly"))
            ),
            tabPanel("How to cite",
              value = "Hidecan_cite", br(),
              includeMarkdown(system.file("help_files/Hidecan_cite.Rmd", package = "viewpoly"))
            )
          )
        )
      ),
      column(width = 2)
      # Add Help content here
    )
  )
}

#' help Server Functions
#'
#' @noRd
mod_help_server <- function(input, output, session, parent_session) {
  ns <- session$ns
}

## To be copied in the UI
# mod_help_ui("help_1")

## To be copied in the server
# mod_help_server("help_1")
