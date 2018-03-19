#' bf_datasets
#'
#' @include models.R
#' @param object BFCLient object
setGeneric("bf_datasets", function(object) {NULL})

#' Wrapper function BFClient
#'
#' @name Blackfynn
#' @rdname Blackfynn
#' @param scope String indicating the API key scope
#' @return A Blackfynn Client object which represents an
#' active session with the Blackfynn platform.
#'
#' @export
Blackfynn <- function(...) new("BFClient", ...)

#' @describeIn BFClient Initializes the BFClient object. It opens
#' a Blackfynn session and stores the API token for the
#' session.
#'
#' @return BFClient object
setMethod("initialize", "BFClient",
          function(.Object, ...) {
            .Object <- callNextMethod()

            # Load Ini file and add api_key/secret
            ini <- read.ini("~/.blackfynn/config.ini")
            if (identical(.Object@scope, character(0))) {
              .Object@scope <- ini$global$default_profile
            }
            api.key <- checkIni[[.Object@scope]]$api_token
            api.secret <- checkIni[[.Object@scope]]$api_secret
            if (identical(api.key, NULL)){
              stop(paste("Scope", .Object@scope, "unknown."))
            }

            # Get Session token
            query <- list("tokenId" = api.key, "secret" = api.secret)
            response <- POST("https://api.blackfynn.io/account/api/session",
                             body = query, encode = "json",
                             content_type_json(), accept_json()) %>% content()

            .Object@org.id <- response$organization
            .Object@session.token <- response$session_token
            .Object@headers <- c("X-ORGANIZATION-ID" = response$organization,
                                 "X-SESSION-ID" = response$session_token,
                                 "Authorization" = paste("Bearer",
                                                         response$session_token))
            # Get Organization
            url <- paste("https://api.blackfynn.io/organizations/",
                         response$organization, sep = "")

            .Object@org <- GET(url, add_headers(.headers = .Object@headers)) %>%
              content() %$% organization %$% name

            .Object
          })

#' Show Blackfynn Client Object
#'
#' This method renders objects of the BFClient class
#'
#' @describeIn BFClient Shows a representation of a Blackfynn Client object.
#' @export
setMethod("show", "BFClient",
          function(object) {
            cat("---Blackfynn Client---\n")
            cat("Organization: ", object@org,"\n")
            cat("----------------------\n")
          }
)

#' @describeIn BFClient
#'     Returns a list of Datasets for the organization.
#'     This is mroe inof
#'
#' @param object BFClient object
#'
#' @export
setMethod("bf_datasets", "BFClient",
          function(object) {
            url <- paste("https://api.blackfynn.io/datasets/organization/",
                         object@org.id, sep = "")
            response <- GET(url, add_headers(.headers = object@headers))
            response
          })
