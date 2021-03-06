#' Datasets
#'
#' @export
#' @template args
#' @param q (character) main query string. optional
#' @param dataset_keys (character) one or more dataset keys. required
#' @details for `cp_dataset()`, separate http requests are made for each 
#' dataset key. unfortunately, the output of `cp_dataset()` is a list for 
#' each dataset key because the nested structure of the data is hard to 
#' rectangularize
#' @return list with two slots
#' - `result` (data.frame/tibble): results, a zero row data.frame
#' if no results found
#' - `meta` (data.frame/tibble): number of results found
#' @examples 
#' if (cp_up("/dataset")) {
#' cp_datasets(limit = 1)
#' }
#' \dontrun{
#' cp_datasets(q = "life")
#' cp_dataset(dataset_keys = 1000)
#' cp_dataset(dataset_keys = c(3, 1000, 1014))
#' }
cp_datasets <- function(q = NULL, start = 0, limit = 10, ...) {
  assert(q, "character")
  assert(start, c("numeric", "integer"))
  assert(limit, c("numeric", "integer"))
  args <- cc(list(q = q, offset = start, limit = limit))
  tmp <- cp_GET(col_base(), "dataset", query = args, ...)
  tmp$result <- tibble::as_tibble(tmp$result)
  tmp <- cp_meta(tmp)
  first_cols <- c("title", "key", "alias", "group", "license", "size")
  tmp$result <- move_cols(tmp$result, first_cols)
  return(tmp)
}

#' @export
#' @rdname cp_datasets
cp_dataset <- function(dataset_keys, ...) {
  assert(dataset_keys, c("numeric", "integer", "character"))
  paths <- file.path("dataset", dataset_keys)
  lapply(paths, function(z) cp_GET(col_base(), z, ...))
}
