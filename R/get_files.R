#' Get list of files with a diresctory on google drive
#'
#' Lists all files under a directory on google drive folder
#'
#' @return A tibble containing file name, id etc.
#'
#' @importFrom magrittr "%>%"
#'
#' @family atlantisdrive functions
#'
#' @examples
#'\dontrun{
#' # get list of files in the Scenario folder under the root
#' get_files(targetDir = "Scenario")
#' get_files(targetDir = "Scen")
#' get_files(targetDir = "ario")
#'
#'}
#'
#' @export

get_files <- function(rootid=atlantisdrive::rootid,targetDir){

  dirs <- get_dirs(rootid)

  selectedDir <- dirs %>% dplyr::filter(grepl(pattern=targetDir,name))

  if (nrow(selectedDir) > 1) {
    message(paste(selectedDir$name,collapse=","))
    stop("Please refine targetDir. Multiple directories found")
  }

  files <- googledrive::drive_ls(googledrive::as_id(selectedDir$id))

  return(files)

}
