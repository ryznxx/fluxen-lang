import std/tables
import "../../types/token_types.nim" as lex

# -----------------------------------------
# Lookup table untuk keyword
# -----------------------------------------
const keywords* = {
  "print": lex.TokenKeywordPrint,
  "fn": lex.TokenKeywordFunction,
  "inf": lex.TokenKeywordInfer,
  "if": lex.TokenKeywordIf,
  "else": lex.TokenKeywordElse,
  "while": lex.TokenKeywordWhile,
  "for": lex.TokenKeywordFor,
  "return": lex.TokenKeywordReturn,
  "true": lex.TokenLiteralBoolean,
  "false": lex.TokenLiteralBoolean,
}.toTable
