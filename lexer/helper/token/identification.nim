import std/strutils
import "../../types/token_types.nim" as lex
import basic

# -----------------------------------------
# Lexer object untuk tracking posisi
# -----------------------------------------
type Lexer* = object
  input*: string
  index*: int
  line*, col*: int

proc initLexer*(input: string): Lexer =
  Lexer(input: input, index: 0, line: 1, col: 1)

proc currentChar*(l: Lexer): char =
  if l.index < l.input.len:
    return l.input[l.index]
  else:
    return '\0'

proc peekChar*(l: Lexer, offset = 1): char =
  let pos = l.index + offset
  if pos < l.input.len:
    return l.input[pos]
  else:
    return '\0'

proc advance*(l: var Lexer) =
  if l.index < l.input.len:
    if l.input[l.index] == '\n':
      inc l.line
      l.col = 0
    else:
      inc l.col
    inc l.index

# -----------------------------------------
# Token builders
# -----------------------------------------
proc newToken*(kind: lex.TokenKind, value: string, line, col: int): lex.TokenObject =
  lex.TokenObject(
    kind: kind,
    value: value,
    lineNumber: line,
    columnNumber: col
  )

proc readIdentifier(l: var Lexer): (string, int, int) =
  let startLine = l.line
  let startCol = l.col
  var ident = ""
  while l.index < l.input.len and isIdentBody(l.currentChar()):
    ident.add(l.currentChar())
    l.advance()
  return (ident, startLine, startCol)

proc readNumber(l: var Lexer): (string, int, int) =
  let startLine = l.line
  let startCol = l.col
  var num = ""
  while l.index < l.input.len and isDigit(l.currentChar()):
    num.add(l.currentChar())
    l.advance()
  return (num, startLine, startCol)


proc readInteger(l: var Lexer): lex.TokenObject =
  let startLine = l.line
  let startCol = l.col
  var value = ""
  while l.index < l.input.len and l.currentChar().isDigit():
    value.add(l.currentChar())
    l.advance()
  return newToken(lex.TokenLiteralInteger, value, startLine, startCol)

proc readFloat(l: var Lexer): lex.TokenObject =
  let startLine = l.line
  let startCol = l.col
  var value = ""
  while l.index < l.input.len and (l.currentChar().isDigit() or l.currentChar() == '.'):
    value.add(l.currentChar())
    l.advance()
  return newToken(lex.TokenLiteralFloat, value, startLine, startCol)

proc readString(l: var Lexer): lex.TokenObject =
  let startLine = l.line
  let startCol = l.col
  var value = ""
  l.advance() # skip opening quote
  while l.index < l.input.len and l.currentChar() != '\"':
    value.add(l.currentChar())
    l.advance()
  if l.currentChar() == '\"':
    l.advance() # skip closing quote
  else:
    echo "Error: unterminated string at line ", l.line, ", col ", l.col
  return newToken(lex.TokenLiteralString, value, startLine, startCol)


proc readOperator*(l: var Lexer): lex.TokenObject =
  let startLine = l.line
  let startCol = l.col
  var op = ""

  # Ambil karakter pertama
  op.add(l.currentChar())
  l.advance()

  # Cek operator 2 karakter
  if l.index < l.input.len:
    let next = l.currentChar()
    case op[0]
    of '=':
      if next == '=': 
        op.add(next)
        l.advance()
        return newToken(lex.TokenOperatorEquality, op, startLine, startCol)
      else:
        return newToken(lex.TokenOperatorAssignment, op, startLine, startCol)
    of '!':
      if next == '=':
        op.add(next)
        l.advance()
        return newToken(lex.TokenOperatorInequality, op, startLine, startCol)
    of '+':
      return newToken(lex.TokenOperatorAddition, op, startLine, startCol)
    of '-':
      return newToken(lex.TokenOperatorSubtraction, op, startLine, startCol)
    of '*':
      return newToken(lex.TokenOperatorMultiplication, op, startLine, startCol)
    of '/':
      return newToken(lex.TokenOperatorDivision, op, startLine, startCol)
    of '<':
      if next == '=':
        op.add(next)
        l.advance()
        return newToken(lex.TokenOperatorLessThanOrEqual, op, startLine, startCol)
      else:
        return newToken(lex.TokenOperatorLessThan, op, startLine, startCol)
    of '>':
      if next == '=':
        op.add(next)
        l.advance()
        return newToken(lex.TokenOperatorGreaterThanOrEqual, op, startLine, startCol)
      else:
        return newToken(lex.TokenOperatorGreaterThan, op, startLine, startCol)
    else:
      discard

  # Default fallback (seharusnya tidak sampai sini)
  return newToken(lex.TokenUnknown, op, startLine, startCol)

proc readSymbol*(l: var Lexer): lex.TokenObject =
  let startLine = l.line
  let startCol = l.col
  var symbol = ""

  symbol.add(l.currentChar())
  l.advance()

  if l.index < l.input.len and l.currentChar() == ':':
    symbol.add(':')
    l.advance()
    return newToken(lex.TokenSymbolDoubleColon, symbol, startLine, startCol)
  else:
    return newToken(lex.TokenSymbolColon, symbol, startLine, startCol)

export
  readString,
  readFloat,
  readInteger,
  readNumber,
  peekChar,
  readIdentifier

