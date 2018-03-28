#' @include core.R
#' @include models.R
NULL

#' @describeIn BFTimeSeries
#'     Shows a representation of a Blackfynn Timeseries object
#'
#' @param object BFClient object
#' @export
setMethod("show", "BFTimeSeries",
          function(object) {
            cat("---Blackfynn Time Series---\n")
            cat("id:   ", object@id,"\n")
            cat("name: ", object@name,"\n")
            cat("start: ", object@start,"\n")
            cat("end: ", object@end,"\n")
            cat("channels: ", object@channels,"\n")
            cat("---------------------------\n")
          }
)
#'
#' #' bf.create.ts
#' #'
#' #' @param resp
#' setGeneric("bf.create.ts", function(resp) {NULL})

#' @describeIn BFTimeSeries
#'     Create a timeseries object
#'
#' @param resp response object from server
setGeneric("bf.create.ts",
          function(resp) {
            ts <- new("BFTimeSeries",
                       id = content$id,
                       name = content$name

                       # for (ch in content$channels)
            )
            ts

          })
