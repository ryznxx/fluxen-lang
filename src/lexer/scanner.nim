import cursor

proc scanTokens(src: string): seq[Token] =
  var c = Cursor(source: src, pos: 0, line: 1, column: 1)
  var tokens: seq[Token] = @[]

  while c.pos < len(c.source):
    let ch = peek(c)

    case ch:
    of 'a'..'z', 'A'..'Z':
      # logika buat identifier/keyword
      discard
    of '"':
      # logika buat string literal
      discard
    of '=':
      tokens.add(Token(kind: TOK_ASSIGN, value: "=", line: c.line, column: c.column))
      discard advance(c)
    of '\n':
      discard advance(c)
    else:
      discard advance(c)

  tokens.add(Token(kind: TOK_EOF, value: "", line: c.line, column: c.column))
  return tokens
