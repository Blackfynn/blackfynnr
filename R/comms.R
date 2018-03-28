#' @include models.R
NULL

#' bf.get
#'
#' @param client BFCLient object
#' @param path "character"
#' @param params "list"
setGeneric("bf.get", function(client, path, params) standardGeneric("bf.get"))

#' bf.post
#'
#' @param client BFCLient object
#' @param path "character"
#' @param params "character"
setGeneric("bf.post", function(client, path, params) standardGeneric("bf.post"))

#'dev bf.delete
#'
#' @param client BFCLient object
#' @param path "character"
#' @param params "character"
setGeneric("bf.delete", function(client, path, params) standardGeneric("bf.delete"))

#' bf.put
#'
#' @param client BFCLient object
#' @param path "character"
#' @param params "character"
setGeneric("bf.put", function(client, path, params) standardGeneric("bf.put"))


#' @describeIn BFClient
#'
#' @param client BFClient
#' @param path "character"
#' @param params "list"
setMethod("bf.get", signature("BFClient",
                    "character",
                    "list"),
          function(client, path, params) {
            url <- paste(client@api.host, path, sep = "")

            cat(url)

            out <- tryCatch(GET(url, add_headers(.headers = client@headers), query = params) %>%
                              stop_for_status() %>% content(),
                            http_404 = function(c) cat("That url doesn't exist\n"),
                            http_403 = function(c) cat("You need to authenticate!\n"),
                            http_400 = function(c) cat("You made a mistake!\n"),
                            http_500 = function(c) cat("The server screwed up\n")
                            )
          })

#' @describeIn BFClient
#'
#' @param client BFClient
#' @param path ""
#' @param params ""
setMethod("bf.post", signature("BFClient",
                              "character",
                              "character"),
          function(client, path, params) {
            url <- paste(client@api.host, path, sep = "")
            out <- tryCatch(POST(url, add_headers(.headers = client@headers)) %>%
                              stop_for_status() %>% content(),
                            http_404 = function(c) cat("That url doesn't exist\n"),
                            http_403 = function(c) cat("You need to authenticate!\n"),
                            http_400 = function(c) cat("You made a mistake!\n"),
                            http_500 = function(c) cat("The server screwed up\n")
            )
          })

#' @describeIn BFClient
#'
#' @param client BFClient
#' @param path ""
#' @param params ""
setMethod("bf.delete", signature("BFClient",
                               "character",
                               "character"),
          function(client, path, params) {
            url <- paste(client@api.host, path, sep = "")
            out <- tryCatch(DELETE(url, add_headers(.headers = client@headers)) %>%
                              stop_for_status() %>% content(),
                            http_404 = function(c) cat("That url doesn't exist\n"),
                            http_403 = function(c) cat("You need to authenticate!\n"),
                            http_400 = function(c) cat("You made a mistake!\n"),
                            http_500 = function(c) cat("The server screwed up\n")
            )
          })

#' @describeIn BFClient
#'
#' @param client BFClient
#' @param path ""
#' @param params ""
setMethod("bf.put", signature("BFClient",
                                 "character",
                                 "character"),
          function(client, path, params) {
            url <- paste(client@api.host, path, sep = "")
            out <- tryCatch(PUT(url, add_headers(.headers = client@headers)) %>%
                              stop_for_status() %>% content(),
                            http_404 = function(c) cat("That url doesn't exist\n"),
                            http_403 = function(c) cat("You need to authenticate!\n"),
                            http_400 = function(c) cat("You made a mistake!\n"),
                            http_500 = function(c) cat("The server screwed up\n")
            )
          })

