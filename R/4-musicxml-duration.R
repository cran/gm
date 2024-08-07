#' @returns A list of two components:
#'
#' - `duration` is a list of `<type>`, `<dot>`, and `<time-modification>`
#' elements.
#'
#' - `tuplet` is a list of `<tuplet>` elements. `tuplet_start` and
#' `tuplet_stop` are already added.
#'
#' @keywords internal
#' @export
to_MusicXML.Duration <- function(x, ...) {
  depth <- length(x[["ratios"]])

  # Non-tuplet
  if (depth == 0) return(to_MusicXML_non_tuplet(x))

  tuplet <- complete_tuplet(x)
  ratios <- tuplet[["ratios"]]

  last <- ratios[[depth]]
  last_take <- last[["take"]]
  last_unit <- last[["unit"]]

  musicxml_type <- MusicXML("type", last_take[["type"]])
  musicxml_dots <- rep(list(MusicXML("dot")), last_take[["dot"]])

  actual_normal_pairs <- get_actual_normal_pairs(tuplet)

  musicxml_time_modification <- to_MusicXML_time_modification(
    actual_normal_pairs,
    last_unit
  )

  musicxml_duration <- c(
    list(musicxml_type),
    musicxml_dots,
    list(musicxml_time_modification)
  )

  musicxml_tuplet_start <- to_MusicXML_tuplet_start(
    tuplet[["tuplet_start"]][[1]],
    ratios,
    actual_normal_pairs
  )

  musicxml_tuplet_stop <- to_MusicXML_tuplet_stop(tuplet[["tuplet_stop"]][[1]])
  musicxml_tuplet <- c(musicxml_tuplet_start, musicxml_tuplet_stop)

  list(
    duration = musicxml_duration,
    tuplet = musicxml_tuplet
  )
}


to_MusicXML_non_tuplet <- function(duration) {
  musicxml_type <- MusicXML("type", duration[["type"]])
  musicxml_dots <- rep(list(MusicXML("dot")), duration[["dot"]])
  musicxml_duration <- c(list(musicxml_type), musicxml_dots)

  list(
    duration = musicxml_duration,
    tuplet = list()
  )
}


#' @returns A list of number pairs. The numbers are the contents of
#' the `<tuplet-number>` elements in `<tuplet-actual>` and
#' `<tuplet-normal>` elements.
#'
#' @noRd
get_actual_normal_pairs <- function(tuplet) {
  pairs <- list()
  take <- tuplet

  for (ratio in tuplet[["ratios"]]) {
    actual <- ratio[["n"]]
    normal <- to_value_base(take) / to_value_base(ratio[["unit"]])

    pair <- c(actual = actual, normal = normal)
    pairs <- c(pairs, list(pair))

    take <- ratio[["take"]]
  }

  pairs
}


#' @description `<normal-type>` and `<normal-dot>` elements represent
#' the deepest unit of a tuplet.
#'
#' @noRd
to_MusicXML_time_modification <- function(actual_normal_pairs, last_unit) {
  musicxml_actual_notes <- MusicXML(
    "actual-notes",
    prod(sapply(actual_normal_pairs, function(pair) pair[["actual"]]))
  )

  musicxml_normal_notes <- MusicXML(
    "normal-notes",
    prod(sapply(actual_normal_pairs, function(pair) pair[["normal"]]))
  )

  musicxml_normal_type <- MusicXML("normal-type", last_unit[["type"]])

  musicxml_normal_dots <- rep(
    list(MusicXML("normal-dot")),
    last_unit[["dot"]]
  )

  contents <- c(
    list(musicxml_actual_notes, musicxml_normal_notes, musicxml_normal_type),
    musicxml_normal_dots
  )

  MusicXML("time-modification", contents)
}


to_MusicXML_tuplet_start <- function(
    tuplet_start,
    ratios,
    actual_normal_pairs) {

  lapply(tuplet_start, function(number) {
    pair <- actual_normal_pairs[[number]]
    ratio <- ratios[[number]]
    take <- ratio[["take"]]
    unit <- ratio[["unit"]]

    musicxml_tuplet_actual <- MusicXML("tuplet-actual", c(
      list(MusicXML("tuplet-number", pair[["actual"]])),
      list(MusicXML("tuplet-type", take[["type"]])),
      rep(list(MusicXML("tuplet-dot")), take[["dot"]])
    ))

    musicxml_tuplet_normal <- MusicXML("tuplet-normal", c(
      list(MusicXML("tuplet-number", pair[["normal"]])),
      list(MusicXML("tuplet-type", unit[["type"]])),
      rep(list(MusicXML("tuplet-dot")), unit[["dot"]])
    ))

    MusicXML(
      "tuplet",
      list(musicxml_tuplet_actual, musicxml_tuplet_normal),
      list(type = "start", number = number, bracket = "yes")
    )
  })
}


to_MusicXML_tuplet_stop <- function(tuplet_stop) {
  lapply(tuplet_stop, function(number) {
    MusicXML("tuplet", attributes = list(type = "stop", number = number))
  })
}
