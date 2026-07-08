#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' 
#' @importFrom shiny tagList tags icon HTML div a img
#' @importFrom bs4Dash bs4Badge bs4DashSidebar bs4DashNavbar bs4DashPage sidebarMenu menuItem menuSubItem dashboardBody tabItems tabItem box dashboardFooter
#' @importFrom shinyWidgets actionBttn
#' @importFrom utils packageVersion zip
#'
#' @noRd
#' 
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    
    tags$head(tags$style(HTML(sprintf(
      ":root { --sidebar-core: var(--%s-core); --sidebar-lite: var(--%s-lite); --sidebar-deep: var(--%s-deep); }",
      "azure", "azure", "azure"
    )))),

    # Skip link must be the first focusable element in the DOM
    tags$a(class="skip-link", "Skip to Main Content", href="#main-body"),
    # Your application UI logic
    bs4DashPage(
      skin = "black",
      bs4DashNavbar(
        title = tagList(
          tags$img(src = 'www/viewpoly_logo.png', height = '40', width = '35')
        ),
        rightUi = tags$li(
          class = "dropdown",
          tags$a(
            href = "#",
            class = "nav-link",
            `data-toggle` = "dropdown",
            icon("info-circle")
          ),
          tags$div(
            class = "dropdown-menu dropdown-menu-right",
            tags$a(
              class = "dropdown-item",
              href = "#",
              "Session Info",
              onclick = "Shiny.setInputValue('session_info_button', Math.random())"
            ),
            tags$a(
              class = "dropdown-item",
              href = "#",
              "Check for Updates",
              onclick = "Shiny.setInputValue('updates_info_button', Math.random())"
            )
          )
        )
      ),
      help = NULL, #This is the default bs4Dash button to control the presence of tooltips and popovers, which can be added as a user help/info feature.
      bs4DashSidebar(
        skin="light",
        status = "warning", #Chose a color that you prefer here
        fixed=TRUE,
        #minified = F,
        expandOnHover = TRUE,
        sidebarMenu(id = "MainMenu",
                    flat = FALSE,
                    tags$li(class = "header", style = "color: grey; margin-top: 10px; margin-bottom: 10px; padding-left: 15px;", "Menu"),
                    menuItem("Home", tabName = "welcome", icon = icon("house"),startExpanded = FALSE),
                    menuItem("Input Data", tabName = "upload", icon = icon("chart-pie")),
                    menuItem("QTL", tabName = "qtl", icon = icon("dna")),
                    menuItem("Genome", tabName = "genes", icon = icon("globe")),
                    menuItem("Map", tabName = "map", icon = icon("map")),
                    menuItem("Hidecan", tabName = "hidecan", icon = icon("eye-slash")),
                    menuItem("Source Code", icon = icon("circle-info"), href = "https://www.github.com/Breeding-Insight/viewpoly"),
                    menuItem("Help", tabName = "help", icon = icon("circle-question"))
        )
      ),
      footer = dashboardFooter(
        right = div(
          style = "display: flex; align-items: center;",  # Align text and images horizontally
          div(
            style = "display: flex; flex-direction: column; margin-right: 15px; text-align: right;",
            div("2026 Breeding Insight"),
            div("Funded by USDA through (UF|IFAS)")
          ),
          div(
            a(
              img(src = "www/usda-logo-color.png", height = "45px"),
              style = "margin-right: 15px;"
            ),
            a(
              img(src = "www/IFAS.jpg", height = "45px")
            ),
            a(
              img(src = "www/cornell_seal_simple_web_b31b1b.png", height = "45px")
            ),
            a(
              img(src = "www/tools_logo.png", height = "70px")
            )
          )
        ),
        left = div(
          style = "display: flex; align-items: center; height: 100%;",  
          sprintf("v%s", as.character(utils::packageVersion("viewpoly")))
        )
      ),
      dashboardBody(
        id="main-body",
        tags$style(
          HTML(
            ".main-footer {
            background-color: white;
            color: grey;
            height: 65px;
            padding-top: 5px;
            padding-bottom: 5px;
          }
          .main-footer a {
            color: grey;
          }"
          )
        ),
        tabItems(
          tabItem(
            tabName = "welcome", mod_Home_ui("Home_1")
          ),
          tabItem(
            tabName = "upload", mod_upload_ui("upload_ui_1")
          ),
          tabItem(
            tabName = "qtl", mod_qtl_view_ui("qtl_view_ui_1")
          ),
          tabItem(
            tabName = "genes", mod_genes_view_ui("genes_view_ui_1")
          ),
          tabItem(
            tabName = "map", mod_map_view_ui("map_view_ui_1")
          ),
          tabItem(
            tabName = "hidecan", mod_hidecan_view_ui("hidecan_view_ui_1")
          ),
          tabItem(
            tabName = "help", mod_help_ui("help_1")
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @importFrom shiny addResourcePath showModal modalDialog modalButton
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'viewpoly'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}
