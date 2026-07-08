#' Home UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList fluidPage fluidRow column HTML a uiOutput renderUI
#' @importFrom bs4Dash box valueBox 
#' 
#'
mod_Home_ui <- function(id){
  ns <- NS(id)
    fluidPage(
      fluidRow(
        column(width = 8,
               fluidRow(
                 column(width = 6,
                        box(
                          title = "ViewPoly", status = "info", solidHeader = FALSE, width = 12, collapsible = FALSE,
                          HTML(
                            "<div style='text-align: center; margin-top: 10px; margin-bottom: 10px;'>
                                <img src='www/viewpoly_logo.png' alt='ViewPoly logo' style='width: 120px; height: 140px;'>
                              </div>",
                            paste0(
                              "<p><b>About VIEWpoly</b></p>",
                              "<p>VIEWpoly is a shiny app and R package for visualizing and exploring results from ",
                              "<a href='https://www.polyploids.org/' target='_blank'>Tools for Polyploids</a> ",
                              "using an interactive graphical user interface. The package allows users to directly upload output files from ",
                              "<a href='https://cran.r-project.org/web/packages/polymapR/index.html' target='_blank'>polymapR</a>, ",
                              "<a href='https://cran.r-project.org/web/packages/mappoly/index.html' target='_blank'>MAPpoly</a>, ",
                              "<a href='https://cran.r-project.org/web/packages/polyqtlR/index.html' target='_blank'>polyqtlR</a>, ",
                              "<a href='https://cran.r-project.org/web/packages/qtlpoly/index.html' target='_blank'>QTLpoly</a>, ",
                              "<a href='https://github.com/jendelman/diaQTL' target='_blank'>diaQTL</a>, ",
                              "<a href='https://github.com/jendelman/GWASpoly' target='_blank'>GWASpoly</a>, ",
                              "<a href='https://cran.r-project.org/web/packages/hidecan/index.html' target='_blank'>HIDECAN</a>, ",
                              "and genomic assembly, variants, annotation and alignment files.</p>",
                              "<p>VIEWpoly graphically displays the QTL profiles, positions, alleles estimated effects, progeny individuals containing specific haplotypes and their breeding values. ",
                              "It is also possible to access marker dosage and parental phase from the linkage map. If genomic information is available, the corresponding QTL positions are interactively explored using JBrowseR interface, allowing the search for candidate genes. ",
                              "It also provides features to download specific information into comprehensive tables and images for further analysis and presentation.</p>",
                              "<p>VIEWpoly was developed during the <b>Tools for Polyploid Project</b> by researchers at <b>Texas A&M University</b> and <b>North Carolina State University</b> and is now updated and maintained by <b>Breeding Insight</b>.</p>"
                            )
                          ),
                          style = "overflow-y: auto; height: 500px"
                        )
                 ),
                 column(width = 6,
                        box(
                          title = "About Breeding Insight", status = "success", solidHeader = FALSE, width = 12, collapsible = FALSE,
                          HTML(
                            "We provide scientific consultation and data management software to the specialty crop and animal breeding communities.
            <ul>
              <li>Genomics</li>
              <li>Phenomics</li>
              <li>Data Management</li>
              <li>Software Tools</li>
              <li>Analysis</li>
            </ul>
            Breeding Insight is funded by the U.S. Department of Agriculture (USDA) Agricultural Research Service (ARS) through University of Florida (UF) - Institute of Food and Agricultural Sciences (IFAS).
            <div style='text-align: center; margin-top: 20px;'>
              <img src='www/BreedingInsight.png' alt='Breeding Insight' style='width: 85px; height: 85px;'>
            </div>"
                          ),
                          style = "overflow-y: auto; height: 500px"
                        )
                 )
               ),
               fluidRow(
                 column(width = 12,
                        uiOutput(ns("news_box"))
                 )
               )
        ),
        column(width = 4,
               a(
                 href = "https://www.breedinginsight.org",  # Replace with your desired URL
                 target = "_blank",  # Optional: opens the link in a new tab
                 valueBox(
                   value = NULL,
                   subtitle = "Learn More About Breeding Insight",
                   icon = icon("link"),
                   color = "purple",
                   gradient = TRUE,
                   width = 11
                 ),
                 style = "text-decoration: none; color: inherit;"  # Optional: removes underline and retains original color
               ),
               a(
                 href = "https://breedinginsight.org/contact-us/",  # Replace with your desired URL
                 target = "_blank",  # Optional: opens the link in a new tab
                 valueBox(
                   value = NULL,
                   subtitle = "Contact Us",
                   icon = icon("envelope"),
                   color = "danger",
                   gradient = TRUE,
                   width = 11
                 ),
                 style = "text-decoration: none; color: inherit;"  # Optional: removes underline and retains original color
               ),
               a(
                 href = "https://cristianetaniguti.github.io/viewpoly_vignettes/VIEWpoly_tutorial.html",  # Replace with your desired URL
                 target = "_blank",  # Optional: opens the link in a new tab
                 valueBox(
                   value = NULL,
                   subtitle = "ViewPoly Tutorial",
                   icon = icon("compass"),
                   color = "info",
                   gradient = TRUE,
                   width = 11
                 ),
                 style = "text-decoration: none; color: inherit;"  # Optional: removes underline and retains original color
               ),
               box(
                 title = "Try the Breedverse!", status = "warning", solidHeader = TRUE, width = 11, collapsible = FALSE,
                 HTML(
                   "We developed an R shiny interface where you can use ALL of our Breeding Insight applications in a single location. This
                   includes applications like BIGapp, GenoBrew, and Allomate, PLUS all of our newly released applications.
                   
                   <a href='https://github.com/Breeding-Insight/Breedverse' target='_blank'>Learn more and see install instructions here</a>
            
                    <div style='text-align: center; margin-top: 20px;'>
                      <img src='www/breedverse_logo.png' alt='BreedVerse' style='width: 120px; height: 140px;'>
                    </div>"
                 ),
                 style = "overflow-y: auto; height: 300px"
               )
        )
      )
    )
}

#' Home Server Functions
#'
#' @importFrom bs4Dash box
#' @importFrom shiny renderUI HTML
#'
#' @noRd
mod_Home_server <- function(input, output, session, parent_session){
  
  ns <- session$ns
  
  output$news_box <- renderUI({
    # Locate NEWS.md via golem helper, then dev working directory fallbacks
    news_file <- app_sys("NEWS.md")
    if (!nzchar(news_file) || !file.exists(news_file)) {
      candidates <- c(
        file.path(getwd(), "NEWS.md"),
        file.path(getwd(), "..", "NEWS.md"),
        file.path(getwd(), "..", "..", "NEWS.md")
      )
      news_file <- Filter(file.exists, candidates)[1]
      if (is.null(news_file) || is.na(news_file)) return(NULL)
    }
    
    lines <- readLines(news_file, warn = FALSE)
    version_starts <- grep("^# ", lines)
    if (length(version_starts) == 0) return(NULL)
    
    # Parse up to the two most recent versions
    n_versions <- min(2, length(version_starts))
    
    parse_section <- function(content) {
      html_parts <- character(0)
      in_list    <- FALSE
      for (line in content) {
        if (grepl("^## ", line)) {
          if (in_list) { html_parts <- c(html_parts, "</ul>"); in_list <- FALSE }
          heading    <- sub("^## ", "", line)
          html_parts <- c(html_parts, paste0("<h5><b>", heading, "</b></h5>"))
        } else if (grepl("^\\* ", line)) {
          if (!in_list) { html_parts <- c(html_parts, "<ul>"); in_list <- TRUE }
          item       <- sub("^\\* ", "", line)
          item       <- gsub("\\*\\*(.+?)\\*\\*", "<b>\\1</b>", item)
          html_parts <- c(html_parts, paste0("<li>", item, "</li>"))
        } else if (nzchar(trimws(line))) {
          if (in_list) { html_parts <- c(html_parts, "</ul>"); in_list <- FALSE }
          text       <- gsub("\\*\\*(.+?)\\*\\*", "<b>\\1</b>", line)
          html_parts <- c(html_parts, paste0("<p>", text, "</p>"))
        }
      }
      if (in_list) html_parts <- c(html_parts, "</ul>")
      html_parts
    }
    
    all_html <- character(0)
    for (i in seq_len(n_versions)) {
      v_start <- version_starts[i]
      v_title <- sub("^# ", "", lines[v_start])
      v_end   <- if (i < length(version_starts)) version_starts[i + 1] - 1 else length(lines)
      content <- lines[(v_start + 1):v_end]
      
      section_html <- parse_section(content)
      
      if (i > 1) all_html <- c(all_html, "<hr/>")
      all_html <- c(all_html,
                    paste0("<h4><b>", v_title, "</b></h4>"),
                    section_html)
    }
    box(
      title       = "What's New",
      status      = "info",
      solidHeader = FALSE,
      width       = 12,
      collapsible = TRUE,
      HTML(paste(all_html, collapse = "\n"))
    )
  })
}

# Suppress global variable and function notes for CRAN checks
utils::globalVariables(c(
  ".__hl__", "Xb", "Yb"
))

## To be copied in the UI
# mod_Home_ui("Home_1")

## To be copied in the server
# mod_Home_server("Home_1")
