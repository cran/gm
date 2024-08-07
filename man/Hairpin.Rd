% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/1-construct-hairpin.R
\name{Hairpin}
\alias{Hairpin}
\title{Create \code{Hairpin} Object}
\usage{
Hairpin(symbol, i, j, to = NULL, above = NULL)
}
\arguments{
\item{symbol}{A single character, which can be \code{"<"} or \code{">"}. They
represent crescendo and diminuendo respectively.}

\item{i, j}{A single positive integer. They indicate the start
and end position of the \code{Hairpin} object in a musical line.}

\item{to}{Optional. A single character or a single positive integer,
which indicates the musical line where to add the \code{Hairpin} object.}

\item{above}{Optional. A single logical, which indicates whether the
\code{Hairpin} object should appear above or below the staff.}
}
\value{
A list of class \code{Hairpin}.
}
\description{
Create a \code{Hairpin} object to represent a crescendo or diminuendo symbol.
}
\examples{
# Create a crescendo
crescendo <- Hairpin("<", 1, 3)
crescendo

# Add it to a `Music`
music <- Music() + Meter(4, 4) + Line(c("C4", "D4", "E4")) + crescendo
music

# Generate the music score
if (interactive()) {
  show(music)
}
}
\seealso{
\code{\link[=+.Music]{+.Music()}} for adding a \code{Hairpin} to
a \code{Music} object.
}
