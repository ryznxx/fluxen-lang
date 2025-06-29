type
  Cursor = object
    source: string
    pos: int
    line: int
    column: int

proc peek(c: Cursor): char =
  result = c.source[c.pos]

proc advance(c: var Cursor): char =
  let current = c.source[c.pos]
  if current == '\n':
    c.line += 1
    c.column = 1
  else:
    c.column += 1
  c.pos += 1
  result = current

proc match(c: Cursor, expected: char): bool =
  result = c.source[c.pos] == expected
