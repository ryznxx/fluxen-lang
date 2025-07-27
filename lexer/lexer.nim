import std/strutils,tables
import types/token_types as lex
import helper/token/basic
import helper/keyword/lookup
import helper/token/identification


# -----------------------------------------
# Main tokenizer
# -----------------------------------------
proc tokenizer*(syntax: string): seq[lex.TokenObject] =
  var l = initLexer(syntax)
  var tokens: seq[lex.TokenObject] = @[]

  while l.index < l.input.len:
    let ch = l.currentChar()

    # Skip whitespace
    if isWhitespace(ch):
      l.advance()
      continue

    # Newline
    if ch == '\n':
      tokens.add(newToken(lex.TokenNewline, "\n", l.line, l.col))
      l.advance()
      continue

    # Identifier / keyword
    if isIdentStart(ch):
      let (ident, line, col) = readIdentifier(l)
      let kind = keywords.getOrDefault(ident, lex.TokenIdentifier)
      tokens.add(newToken(kind, ident, line, col))
      continue

    # Number
    if isDigit(ch):
      let next = l.peekChar()
      if next == '.':
        tokens.add(readFloat(l))
      else:
        tokens.add(readInteger(l))
      continue

    # string identification
    if ch == '"':
      tokens.add(readString(l))
      continue

    # Operator
    if ch in {'+', '-', '*', '/', '=', '!', '<', '>'}:
      tokens.add(readOperator(l))
      continue


    if ch == ':':
      tokens.add(readSymbol(l))  # handle ':' atau '::'
      continue

    # Single-character symbols
    case ch:
    of '(':
      tokens.add(newToken(lex.TokenSymbolParenthesisOpen, $ch, l.line, l.col))
    of ')':
      tokens.add(newToken(lex.TokenSymbolParenthesisClose, $ch, l.line, l.col))
    of '{':
      tokens.add(newToken(lex.TokenSymbolBraceOpen, $ch, l.line, l.col))
    of '}':
      tokens.add(newToken(lex.TokenSymbolBraceClose, $ch, l.line, l.col))
    of '[':
      tokens.add(newToken(lex.TokenSymbolBracketOpen, $ch, l.line, l.col))
    of ']':
      tokens.add(newToken(lex.TokenSymbolBracketClose, $ch, l.line, l.col))
    of ',':
      tokens.add(newToken(lex.TokenSymbolComma, $ch, l.line, l.col))
    of ';':
      tokens.add(newToken(lex.TokenSymbolSemicolon, $ch, l.line, l.col))
    of '.':
      tokens.add(newToken(lex.TokenSymbolDot, $ch, l.line, l.col))
    else:
      tokens.add(newToken(lex.TokenUnknown, $ch, l.line, l.col))

    l.advance()

  tokens.add(newToken(lex.TokenEndOfFile, "", l.line, l.col))
  return tokens