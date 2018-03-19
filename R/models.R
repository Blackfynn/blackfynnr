#' Class BFClient.
#'
#' This is the main interface class for the Blackfynn R
#' client. It handles the session and should be passed to
#' all method calls.
#'
#' @slot scope The scope in the configuration file
#' @slot org The organization for the current session
#'
#' @export
setClass("BFClient",
         slots = c(scope = "character",
                   org = "character",
                   org.id = "character",
                   session.token = "character",
                   headers = "character"))


