import std/tables

type
  TokenType = enum
    # Keywords
    TOK_RAW, TOK_FIX, TOK_PRINT, TOK_IF, TOK_ELSE, TOK_FOR, TOK_WHILE, TOK_FUNC

    # Symbols
    TOK_ASSIGN      # =
    TOK_COLON       # :
    TOK_ARROW       # =>
    TOK_DOTDOT      # ..
    TOK_LPAREN      # (
    TOK_RPAREN      # )
    TOK_NEWLINE     # \n

    # General
    TOK_IDENTIFIER
    TOK_STRING
    TOK_NUMBER
    TOK_EOF


let keywords = {
  "raw": TOK_RAW,
  "fix": TOK_FIX,
  "print": TOK_PRINT,
  "if": TOK_IF,
  "else": TOK_ELSE,
  "for": TOK_FOR,
  "while": TOK_WHILE,
  "func": TOK_FUNC
}.toTable

let symbols = {
  "=": TOK_ASSIGN,
  ":": TOK_COLON,
  "=>": TOK_ARROW,
  "..": TOK_DOTDOT,
  "(": TOK_LPAREN,
  ")": TOK_RPAREN
}.toTable
