% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cp_importer.R
\name{cp_importer}
\alias{cp_importer}
\title{Importer metrics}
\usage{
cp_importer(
  dataset_key = NULL,
  state = NULL,
  running = FALSE,
  start = 0,
  limit = 10,
  ...
)
}
\arguments{
\item{dataset_key}{(character) a dataset key to filter by. optional}

\item{state}{(character) filter listed import metrics by their state,
e.g. the last failed import. one of: downloading, processing, inserting,
unchanged, finished, canceled, failed. optional}

\item{running}{(logical) if only a list of running imports should
be returned. default: \code{FALSE}. optional}

\item{start}{(integer) requested number of offset records. Default: 0}

\item{limit}{(integer) requested number of maximum records to be returned.
Default: 10; max: 1000}

\item{...}{curl options passed on to \code{\link[crul]{verb-GET}}}
}
\value{
a named list, with slots \code{offset} (integer), \code{limit} (integer),
\code{total} (integer), \code{result} (list), \code{empty} (boolean),
and \code{last} (boolean). The \code{result} slot is a list itself, with any
number of results as named lists
}
\description{
Importer metrics
}
\examples{
if (cp_up("/importer?limit=1")) {
cp_importer(limit = 1)
}
}
