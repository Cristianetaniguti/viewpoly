#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom utils capture.output sessionInfo
#' @importFrom httr GET status_code content
#' @importFrom curl new_handle curl_fetch_memory
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic
  # Upload size
  options(shiny.maxRequestSize=50000*1024^2)
  
  ## Start modules
  # Home view
  callModule(mod_Home_server,
             "Home_1",
             parent_session=session)
  
  datas <- callModule(mod_upload_server,
                      "upload_ui_1", 
                      parent_session=session)
  
  # QTL view
  callModule(mod_qtl_view_server,
             "qtl_view_ui_1",
             loadMap = datas$loadMap,
             loadQTL = datas$loadQTL,
             parent_session=session)
  
  # Genes view
  callModule(mod_genes_view_server,
             "genes_view_ui_1", 
             loadMap = datas$loadMap,
             loadQTL = datas$loadQTL,
             loadJBrowse_fasta = datas$loadJBrowse_fasta, 
             loadJBrowse_gff3 = datas$loadJBrowse_gff3, 
             loadJBrowse_vcf = datas$loadJBrowse_vcf, 
             loadJBrowse_align = datas$loadJBrowse_align, 
             loadJBrowse_wig = datas$loadJBrowse_wig, 
             parent_session=session)
  
  # Map view
  callModule(mod_map_view_server,
             "map_view_ui_1", 
             loadMap = datas$loadMap,
             loadQTL = datas$loadQTL,
             parent_session=session)
  
  # Hidecan view
  callModule(mod_hidecan_view_server,
             "hidecan_view_ui_1",
             loadHidecan = datas$loadHidecan,
             parent_session=session)


  #Session info popup
  observeEvent(input$session_info_button, {
    showModal(modalDialog(
      title = "Session Information",
      size = "l",
      easyClose = TRUE,
      footer = tagList(
        modalButton("Close"),
        downloadButton("download_session_info", "Download")
      ),
      pre(
        paste(capture.output(sessionInfo()), collapse = "\n")
      )
    ))
  })
  
  #Check for updates from GitHub for viewpoly
  get_latest_github_commit <- function(repo, owner) {
    url <- paste0("https://api.github.com/repos/", owner, "/", repo, "/releases/latest")
    response <- GET(url)
    content <- content(response, "parsed")
    
    if (status_code(response) == 200) {
      tag_name <- content$tag_name
      clean_tag_name <- sub("-.*", "", tag_name)
      clean_tag_name <- sub("v", "", clean_tag_name)
      return(clean_tag_name)
    } else {
      return(NULL)
    }
  }
  
  is_internet_connected <- function() {
    handle <- new_handle()
    success <- tryCatch({
      curl_fetch_memory("https://www.google.com", handle = handle)
      TRUE
    }, error = function(e) {
      FALSE
    })
    return(success)
  }
  
  observeEvent(input$updates_info_button, {
    # Check internet connectivity
    if (!is_internet_connected()) {
      # Display internet connectivity issues message
      showModal(modalDialog(
        title = "No Internet Connection",
        easyClose = TRUE,
        footer = tagList(
          modalButton("Close")
        ),
        "Please check your internet connection and try again."
      ))
      return()
    }
    
    package_name <- "viewpoly"
    repo_name <- "viewpoly" # GitHub repo name
    repo_owner <- "Breeding-Insight" # User or organization name
    
    # Get the installed version
    installed_version <- as.character(packageVersion(package_name))
    
    # Get the latest version from GitHub (release tag)
    latest_version <- get_latest_github_commit(repo_name, repo_owner)

    if (is.null(latest_version) || !nzchar(latest_version)) {
      message_html <- paste(
        "Installed version:", installed_version, "<br>",
        "Unable to check for updates right now (GitHub API request failed)."
      )
    } else if (utils::compareVersion(latest_version, installed_version) == 1) {
      message_html <- paste(
        "Installed version:", installed_version, "<br>",
        "Latest version:", latest_version, "<br>",
        "<span>A new version is available on GitHub!</span><br>",
        "<span style='color: red;'>Please update your package.</span>"
      )
    } else {
      message_html <- paste(
        "Installed version:", installed_version, "<br>",
        "Latest version:", latest_version, "<br>",
        "Your package is up-to-date!"
      )
    }
    
    # Display message in a Shiny modal
    showModal(modalDialog(
      title = "viewpoly Updates",
      size = "m",
      easyClose = TRUE,
      footer = tagList(
        modalButton("Close")
      ),
      # Use HTML to format the message and include styling
      HTML(message_html)
    ))
  })
  
  #Download Session Info
  output$download_session_info <- downloadHandler(
    filename = function() {
      paste("session_info_", Sys.Date(), ".txt", sep = "")
    },
    content = function(file) {
      writeLines(paste(capture.output(sessionInfo()), collapse = "\n"), file)
    }
  )
}
