## ----include = FALSE, message = FALSE-----------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  
  # To prevent CRAN from building this vignette:
  # 
  # 1. Add `BUILD_VIGNETTE=TRUE` in .Renviron before calling
  # `devtools::build()` or `R CMD build`, to build this vignette locally.
  # 
  # 2. Remove `BUILD_VIGNETTE=TRUE` before calling `R CMD check --as-cran`.
  eval = Sys.getenv("BUILD_VIGNETTE") == "TRUE"
)

## ----message = FALSE----------------------------------------------------------
library(gm)

## -----------------------------------------------------------------------------
music <- 
  Music() +
  Meter(4, 4) +
  Line(c("C5", "D5", "E5", "F5"))
  
show(music)

## -----------------------------------------------------------------------------
music <- music + Tempo(180)
show(music)

## -----------------------------------------------------------------------------
music <- music + Articulation(">", 1)
show(music)

## -----------------------------------------------------------------------------
music <- music + Pedal(1, 4)
show(music)

## -----------------------------------------------------------------------------
music <- 
  Music() +
  Meter(4, 4) +
  Line(c("C5", "D5", "E5", "F5"))

music

## -----------------------------------------------------------------------------
line <- Line(
  pitches = c("C5", "D5", "E5", "F5"),
  durations = c(0.5, 1, 1.5, 2)
)

music <- Music() + Meter(5, 4) + line
show(music, "score")

## -----------------------------------------------------------------------------
line <- Line(
  pitches = c("A3", "E4", "C5", "B3", "E4", "G#4"),
  durations = c("quarter.", "eighth", "quarter")
)

music <- Music() + Meter(3, 4) + line
show(music)

## -----------------------------------------------------------------------------
line <- Line(c("C5", "D5", "E5"), bar = 2, offset = 1)
music <- Music() + Meter(4, 4) + line
show(music, "score")

## -----------------------------------------------------------------------------
pitches <- c(64, 65, 69, 71, 72, 76)
music <- Music() + Meter(4, 4)

for (i in 0:8) {
  music <- music + Line(pitches, offset = 0.5 * i)
}

show(music)

## -----------------------------------------------------------------------------
line_1 <- Line(c("C5", "D5", "E5", "F5"))
line_2 <- Line(c("E4", "G4"), 2)
line_3 <- Line("C4", 4)
music <- Music() + Meter(4, 4) + line_1 + line_2 + line_3
show(music, "score")

## -----------------------------------------------------------------------------
line_1 <- Line(c("C5", "D5", "E5", "F5"), name = "a")
line_2 <- Line(c("E4", "G4"), 2, name = "b")
line_3 <- Line("C4", 4, name = "c")
music <- Music() + Meter(4, 4) + line_1 + line_2 + line_3
show(music, "score")

## -----------------------------------------------------------------------------
line_1 <- Line(c("C5", "D5", "E5", "F5"), name = "a")
line_2 <- Line(c("E4", "G4"), 2, name = "b")
line_3 <- Line("C4", 4, name = "c", to = "a", after = FALSE)
music <- Music() + Meter(4, 4) + line_1 + line_2 + line_3
show(music, "score")

## -----------------------------------------------------------------------------
music <- 
  Music() +
  Meter(4, 4) +
  Line(c("C5", "D5", "E5", "F5")) +
  Line(c("C4", "G4"), 2, as = "part")

show(music, "score")

## -----------------------------------------------------------------------------
music <- 
  Music() +
  Meter(4, 4) +
  Line(c("C5", "D5", "E5", "F5")) +
  Line(c("C4", "G4"), 2, as = "staff")

show(music, "score")

## -----------------------------------------------------------------------------
music <- 
  Music() +
  Meter(4, 4) +
  Line(c("C5", "D5", "E5", "F5")) +
  Line(c("C4", "G4"), 2, as = "voice")

show(music, "score")

## -----------------------------------------------------------------------------
music <- 
  Music() +
  Meter(4, 4) +
  Line(c("C5", "D5", "E5", "F5")) +
  Line(c("C4", "G4"), 2, as = "segment", bar = 2)

show(music, "score")

## -----------------------------------------------------------------------------
line_1 <- Line(c("C5", "D5", "E5", "F5"), name = "a")
line_2 <- Line(c("E4", "G4"), 2, name = "b", as = "voice")
line_3 <- Line("C4", 2, name = "c", as = "staff", offset = 2)
music <- Music() + Meter(4, 4) + line_1 + line_2 + line_3
show(music, "score")

## -----------------------------------------------------------------------------
music$lines

## -----------------------------------------------------------------------------
pitches <- c("C4", "C#4", "D-4", "C##4", "D--4")
music <- Music() + Meter(5, 4) + Line(pitches)
show(music, "score")

## -----------------------------------------------------------------------------
pitches <- 61:64
music <- Music() + Meter(4, 4) + Line(pitches)
show(music, "score")

## -----------------------------------------------------------------------------
pitches <- c(60, 62, 64, 65)
music <- Music() + Meter(4, 4) + Line(pitches)
show(music)

## -----------------------------------------------------------------------------
pitches <- pitches + 7
music <- Music() + Meter(4, 4) + Line(pitches)
show(music)

## -----------------------------------------------------------------------------
pitches <- c("C#5", "D-5", "B##4")
music <- Music() + Meter(3, 4) + Line(pitches)
show(music, "score")

## -----------------------------------------------------------------------------
pitches <- c(73, 73)
music <- Music() + Meter(1, 4) + Key(7) + Key(-7, bar = 2) + Line(pitches)
show(music, "score")

## -----------------------------------------------------------------------------
pitches <- c("C4", NA, "D4", NA)
music <- Music() + Meter(4, 4) + Line(pitches)
show(music, "score")

## -----------------------------------------------------------------------------
pitches <- c("C4", NA, "D4", NA)
music <- Music() + Meter(4, 4) + Line(pitches, bar = 2)
show(music, "score")

## -----------------------------------------------------------------------------
pitches <- "C4"
music <- Music() + Meter(4, 4) + Line(pitches)
show(music, "score")

## -----------------------------------------------------------------------------
pitches <- list("C4", c("E4", "G4"), NA, c(64, 67))
music <- Music() + Meter(4, 4) + Line(pitches)
show(music)

## -----------------------------------------------------------------------------
keys <- -7:7

for (key in keys) {
  print(Key(key))
}

## -----------------------------------------------------------------------------
music <- Music() + Meter(1, 4) + Line(durations = rep(1, length(keys)))

for (i in seq_along(keys)) {
  music <- music + Key(keys[i], bar = i)
}

show(music, "score")

## -----------------------------------------------------------------------------
music <-
  Music() +
  Meter(1, 4) +
  Line(NA) +
  Line(NA, as = "staff") +
  Line(NA) +
  Line(NA, as = "staff") +
  Key(1, to = 1) +
  Key(-1, to = 3, scope = "staff")

show(music, "score")

## -----------------------------------------------------------------------------
clef <- Clef("F")
music <- Music() + Meter(2, 4) + Line(c("C3", "D3")) + clef
show(music, "score")

## -----------------------------------------------------------------------------
Clef("G")

Clef("G", line = 1)

Clef("G", octave = 1)

Clef("G", octave = -1)

Clef("F")

Clef("F", line = 3)

Clef("F", line = 5)

Clef("F", octave = 1)

Clef("F", octave = -1)

Clef("C")

Clef("C", line = 1)

Clef("C", line = 2)

Clef("C", line = 4)

Clef("C", line = 5)

## -----------------------------------------------------------------------------
music <-
  Music() +
  Meter(2, 4) +
  Line(c("C3", "D3"), bar = 2) +
  Clef("F", bar = 2, offset = 1)

show(music, "score")

## -----------------------------------------------------------------------------
durations <- c("q.", "eighth", "quarter..", "16th")
music <- Music() + Meter(4, 4) + Line(durations = durations)
show(music, "score")

## ----echo = FALSE-------------------------------------------------------------
duration_types <- gm:::duration_types

duration_types$value <- duration_types$value |>
  lapply(gm:::to_fraction) |>
  lapply(\(fraction) {
    if (fraction[2] == 1) fraction[1] else paste(fraction, collapse = "/")
  }) |>
  as.character()

names(duration_types) <- c("Duration Type", "Abbreviation", "Value")
knitr::kable(duration_types)

## -----------------------------------------------------------------------------
durations <- 1:5
music <- Music() + Meter(5, 4) + Line("C4", durations)
show(music, "score")

## -----------------------------------------------------------------------------
durations <- rep("half/3", 3)
music <- Music() + Meter(2, 4) + Line(durations = durations)
show(music, "score")

## -----------------------------------------------------------------------------
durations <- c("half/3", "half/3*(half/quarter)")
music <- Music() + Meter(2, 4) + Line(durations = durations)
show(music, "score")

## -----------------------------------------------------------------------------
music <-
  Music() +
  Meter(1, 4) +
  Meter(2, 4, bar = 2) +
  Line(c("C4", "E4", "G4"))

show(music, "score")

## -----------------------------------------------------------------------------
music <-
  Music() +
  Meter(4, 4, actual_number = 1, actual_unit = 4) +
  Meter(4, 4, bar = 2, invisible = TRUE) +
  Line(c("A4", "B4", "C5", "D5", "E5"))

show(music, "score")

## -----------------------------------------------------------------------------
music <- 
  Music() +
  Meter(4, 4) +
  Line(60:67) +
  Tempo(90) +
  Tempo(120, bar = 2) +
  Tempo(200, bar = 2, offset = 2)

show(music)

## -----------------------------------------------------------------------------
music <- 
  Music() +
  Meter(4, 4) +
  Line(60:67) +
  Tempo(90, marking = "Slowly!!") +
  Tempo(200, offset = 2, marking = "quarter. = quarter") +
  Tempo(120, bar = 2, marking = "Allegro (quarter = 110-130)")

show(music, "score")

## -----------------------------------------------------------------------------
music <-
  Music() +
  Meter(4, 4) +
  Line(list("C4", NA, c("C4", "E4")), list(1, "quarter", 2))

show(music, "score")

## -----------------------------------------------------------------------------
music$notes

## -----------------------------------------------------------------------------
notes <- Line(c("C4", "C4"))
tie <- Tie(1)
music <- Music() + Meter(2, 4) + notes + tie
show(music, "score")

## -----------------------------------------------------------------------------
chords <- Line(list(c("C4", "E4"), c("C4", "E4")))
tie <- Tie(1, 2)
music <- Music() + Meter(2, 4) + chords + tie
show(music, "score")

## -----------------------------------------------------------------------------
chords <- Line(list(c("C4", "E4"), c("C4", "E4")))
tie <- Tie(1)
music <- Music() + Meter(2, 4) + chords + tie
show(music, "score")

## -----------------------------------------------------------------------------
cross_bar_note <- Line("C4", 4)
music <- Music() + Meter(1, 4) + cross_bar_note
show(music, "score")

## -----------------------------------------------------------------------------
line <- Line(c("A3", "B3", "C4", "D4"), c(0.25, 0.25, 1, 1))
music <- Music() + Meter(2, 4) + line + Grace(1) + Grace(2)
show(music)

## -----------------------------------------------------------------------------
accidental <- Accidental("natural", 2)
music <- Music() + Meter(2, 4) + Line(c("C4", "C4")) + accidental
show(music, "score")

## -----------------------------------------------------------------------------
notehead <- Notehead(1, shape = "diamond", color = "#FF0000")
music <- Music() + Meter(2, 4) + Line(c("C4", "C4")) + notehead
show(music, "score")

## -----------------------------------------------------------------------------
stem <- Stem("none", 1)
music <- Music() + Meter(2, 4) + Line(c("C4", "C4")) + stem
show(music, "score")

## -----------------------------------------------------------------------------
music <- 
  Music() +
  Meter(4, 4) +
  Line(c("C4", "D4", "E4", "F4")) +
  Articulation(">", 1) +
  Articulation(".", 2) +
  Articulation("'", 3) +
  Articulation("-", 4)
  
show(music)

## ----echo = FALSE-------------------------------------------------------------
articulations <- gm:::articulations
names(articulations) <- c("MuseScore", "MusicXML", "Symbol")
knitr::kable(articulations)

## -----------------------------------------------------------------------------
music <- 
  Music() +
  Meter(4, 4) +
  Line(c("C4", "D4", "E4", "F4")) +
  Fermata(4, shape = "square")
  
show(music, "score")

## -----------------------------------------------------------------------------
music <- 
  Music() +
  Meter(4, 4) +
  Line(c("C4", "D4", "E4", "F4")) +
  Breath(2)
  
show(music, "score")

## -----------------------------------------------------------------------------
music <- 
  Music() +
  Meter(7, 4) +
  Line(c("B4", "C5", "D5", "E5", "F5", "G5", "A5")) +
  Tremolo(3, 1) +
  Turn(2, inverted = TRUE) +
  Mordent(3, long = TRUE) + 
  Trill(4) + 
  Trill(5, 6) +
  Schleifer(7)

show(music)

## -----------------------------------------------------------------------------
music <- Music() + Meter(4, 4) + Line(60:63) + Slur(1, 4)
show(music, "score")

## -----------------------------------------------------------------------------
music <- 
  Music() +
  Meter(4, 4) +
  Line(c("C4", "D4")) +
  Line(c("E4", "F4"), offset = 2, as = "staff") +
  Slur(1, 2, to = 1, to_j = 2)

show(music, "score")

## -----------------------------------------------------------------------------
music <-
  Music() +
  Meter(4, 4) +
  Line(60:67) +
  Dynamic("p", 1) +
  Dynamic("mf", 3) +
  Dynamic("fff", 5) +
  Dynamic("pp", 7)

show(music)

## -----------------------------------------------------------------------------
pitches <- 74:50
velocities <- seq(5, 127, 5)
music <- Music() + Meter(4, 4) + Tempo(200) + Line(pitches, 0.5)

for (i in seq_along(velocities)) {
  music <- music + Velocity(velocities[i], 1, i)
}

show(music)

## -----------------------------------------------------------------------------
music <-
  Music() +
  Meter(4, 4) +
  Line(60:67) +
  Dynamic("pp", 1) +
  Dynamic("ff", 8) +
  Hairpin("<", 2, 7)

show(music)

## -----------------------------------------------------------------------------
pitches <- c("C4", "D4", "E4", "F4")

music <-
  Music() +
  Meter(4, 4) +
  Line(pitches) +
  Line(pitches, bar = 2)

show(music)  

## -----------------------------------------------------------------------------
instrument_1 <- Instrument(10, 1)
instrument_1

## -----------------------------------------------------------------------------
instrument_2 <- Instrument(76, 2)
instrument_2

## -----------------------------------------------------------------------------
music <- music + instrument_1 + instrument_2
show(music)

## ----echo = FALSE-------------------------------------------------------------
path <- "/Applications/MuseScore 3.app/Contents/MacOS/mscore"
options(gm.musescore_path = path)

## -----------------------------------------------------------------------------
pitches <- c("C4", "D4", "E4", "F4")

music <-
  Music() +
  Meter(4, 4) +
  Line(pitches) +
  Line(pitches, bar = 2) + 
  Line(pitches, bar = 3) +
  Instrument(1, 1, pan = -90) +
  Instrument(1, 2, pan = 0) +
  Instrument(1, 3, pan = 90)

show(music)  

## ----echo = FALSE-------------------------------------------------------------
options(gm.musescore_path = NULL)

## -----------------------------------------------------------------------------
music <-
  Music() +
  Meter(4, 4) +
  Key(1) +
  Tempo(60) +
  
  Line(c("B4", "G5", "F#5", "E5"), c("8", "h.", "8", "8"), bar = 2) +
  Grace(1) +
  
  Line(rep(c("E2", "B2", "G3", "E3", "C4", "B3"), 4), "q/3", as = "staff") +
  Clef("F") +
  Dynamic("p", 1) +
  Pedal(1, 12) +
  Pedal(13, 24)

show(music)

## -----------------------------------------------------------------------------
music <-
  Music() +
  Meter(4, 4) +
  Line(60:63) +
  Lyric("My_love-", 1) +
  Lyric("-ly", 2) +
  Lyric("cat_", 3) +
  Lyric("_", 4) +
  Lyric("Hey", 1, verse = 2) +
  Lyric("Jude", 2, verse = 2)
  
show(music, "score")

## -----------------------------------------------------------------------------
music <- Music() + Meter(4, 4) + Line("C5")
show(music, "score", musescore = "-r 400 -T 100")

