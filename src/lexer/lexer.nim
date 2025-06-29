import ./scanner

proc tokenize(code: string): seq[Token] =
  return scanTokens(code)
