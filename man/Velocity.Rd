% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/1-construct-velocity.R
\name{Velocity}
\alias{Velocity}
\title{Create \code{Velocity} Object}
\usage{
Velocity(velocity, to = NULL, i = NULL, j = NULL)
}
\arguments{
\item{velocity}{A single integer between \code{0} and \code{127}, which indicates
the velocity to apply.}

\item{to}{Optional. A single character or a single positive integer,
which indicates the musical line where to apply the velocity. If not
provided, the velocity will be applied to all notes.}

\item{i}{Optional. A single positive integer, which represents the
position of the velocity in a musical line.}

\item{j}{Optional. A single positive integer, which represents the
position of the velocity in a chord.}
}
\value{
A list of class \code{Velocity}.
}
\description{
Create a \code{Velocity} object to set some notes' velocities.
}
\examples{
# Create a `Velocity`
velocity <- Velocity(10)
velocity

# Add it to a `Music`
music <- Music() + Meter(4, 4) + Line(c("C4", "D4")) + velocity
music

# Generate the music score
if (interactive()) {
  show(music)
}
}
\seealso{
\itemize{
\item \code{\link[=+.Music]{+.Music()}} for adding a \code{Velocity} to a \code{Music} object
\item \code{\link[=Dynamic]{Dynamic()}} for adding dynamic markings
}
}
