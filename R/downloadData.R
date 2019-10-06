
#' Base url to gather data from
#' @param baseUrl contains the URL for API Call
#' @export
baseUrl <- "https://data.police.uk/api/crimes-no-location?category=all-crime&force=leicestershire"

#' Connects to the API and returns data
#' @import httr
#' @import jsonlite
#' @import ggplot2
#' @import dplyr
#' @return jsndata - A json object
#' @export 
#' @examples  
#' datasuccess()
datasuccess <- function(){
  #require("httr")
  #require("jsonlite")
  #require("dplyr")
  #require("ggplot2")
  base_url <- "https://data.police.uk/api/crimes-no-location?category=all-crime&force=leicestershire"
  rawdata <- httr::GET(base_url)
  txtdata <- httr::content(rawdata,as='text')
  if(rawdata$status_code == 200){
    jsndata <- fromJSON(txtdata)
    return (jsndata)
  }
  else
    print("Error : Something wrong with the URL.Response code 404 returned..")
  stop()
}