import std/strutils

# -----------------------------------------
# Helper procs
# -----------------------------------------

proc isIdentStart*(c: char): bool =
  c.isAlphaAscii or c == '_'

proc isIdentBody*(c: char): bool =
  c.isAlphaNumeric or c == '_'

proc isWhitespace*(c: char): bool =
  c in {' ', '\t', '\r'}

# proc isDigit*(c: char): bool =
#   c in {'0'..'9'}

proc isOperator*(c: char): bool =
  c in {'+', '-', '*', '/', '=', '!', '<', '>'}