#' @include connection.R
NULL

#' Quote postgres strings and identifiers.
#'
#' @param conn A \linkS4class{PqConnection} created by \code{dbConnect()}
#' @param x A character to escaped
#' @param ... Other arguments needed for compatibility with generic
#' @examples
#' library(DBI)
#' con <- dbConnect(RPostgres::Postgres())
#'
#' x <- c("a", "b c", "d'e", "\\f")
#' dbQuoteString(con, x)
#' dbQuoteIdentifier(con, x)
#' @name quote
NULL

#' @export
#' @rdname quote
setMethod("dbQuoteString", c("PqConnection", "character"), function(conn, x, ...) {
  is_na <- is.na(x)
  res <- SQL(connection_escape_string(conn@ptr, x))
  res[is_na] <- SQL("NULL")
  res
})

#' @export
#' @rdname quote
setMethod("dbQuoteIdentifier", c("PqConnection", "character"), function(conn, x, ...) {
  SQL(connection_escape_identifier(conn@ptr, x))
})
