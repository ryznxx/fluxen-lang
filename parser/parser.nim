import std/[tables, strutils]
import "../lexer/types/token_types.nim" as lex
import "../ast/node.nim" as ast

type Parser* = object
  tokens: seq[lex.TokenObject]
  pos: int

proc initParser*(toks: seq[lex.TokenObject]): Parser =
  Parser(tokens: toks, pos: 0)

proc current(p: Parser): lex.TokenObject =
  if p.pos < p.tokens.len: p.tokens[p.pos]
  else: lex.TokenObject(kind: lex.TokenEndOfFile, value: "")

proc advance(p: var Parser) =
  inc p.pos

proc consume(p: var Parser; kind: lex.TokenKind): string =
  let tok = p.current
  if tok.kind != kind:
    raise newException(ValueError,
      "Expected " & $kind & " at line " & $tok.lineNumber)
  result = tok.value
  p.advance()

# ---------- precedence ----------
const precedence = {
  lex.TokenOperatorAddition: 1,
  lex.TokenOperatorSubtraction: 1,
  lex.TokenOperatorMultiplication: 2,
  lex.TokenOperatorDivision: 2
}.toTable

# ---------- grammar ----------
proc parseExpr(p: var Parser): ast.Node
proc parseUnary(p: var Parser): ast.Node
proc parsePrimary(p: var Parser): ast.Node

proc parsePrimary(p: var Parser): ast.Node =
  let tok = p.current
  case tok.kind
  of lex.TokenLiteralInteger:
    let val = parseInt(tok.value)
    advance(p)
    ast.Node(kind: ast.nkIntLit, value: val)
  of lex.TokenSymbolParenthesisOpen:
    advance(p)
    let node = p.parseExpr()
    discard p.consume(lex.TokenSymbolParenthesisClose)
    node
  else:
    raise newException(ValueError, "Unexpected token: " & tok.value)

proc parseUnary(p: var Parser): ast.Node =
  let tok = p.current
  if tok.kind == lex.TokenOperatorSubtraction and tok.value == "-":
    advance(p)
    ast.Node(kind: ast.nkUnaryOp, unaryOp: "-", operand: p.parseUnary())
  else:
    p.parsePrimary()

proc parseExpr(p: var Parser): ast.Node =
  var left = p.parseUnary()
  while true:
    case p.current.kind
    of lex.TokenOperatorAddition, lex.TokenOperatorSubtraction,
       lex.TokenOperatorMultiplication, lex.TokenOperatorDivision:
      let op = p.current.value
      let prec = precedence.getOrDefault(p.current.kind, 0)
      advance(p)
      var right = p.parseUnary()

      # precedence climbing
      while true:
        case p.current.kind
        of lex.TokenOperatorAddition, lex.TokenOperatorSubtraction,
           lex.TokenOperatorMultiplication, lex.TokenOperatorDivision:
          let nextPrec = precedence.getOrDefault(p.current.kind, 0)
          if nextPrec <= prec:
            break
          right = ast.Node(
            kind: ast.nkBinOp,
            binOp: p.current.value,   # <-- binOp
            left: right,
            right: p.parseUnary()
          )
          advance(p)
        else:
          break
      left = ast.Node(
        kind: ast.nkBinOp,
        binOp: op,                   # <-- binOp
        left: left,
        right: right
      )
    else:
      break
  left

proc parse*(toks: seq[lex.TokenObject]): ast.Node =
  var p = initParser(toks)
  result = p.parseExpr()
  if p.current.kind != lex.TokenEndOfFile:
    raise newException(ValueError, "Trailing tokens")