import "../ast/node.nim" as ast

proc eval*(node: ast.Node): int64 =
  case node.kind
  of ast.nkIntLit:
    node.value
  of ast.nkBinOp:
    let l = eval(node.left)
    let r = eval(node.right)
    case node.binOp
    of "+": l + r
    of "-": l - r
    of "*": l * r
    of "/": l div r
    else: raise newException(ValueError, "Unknown bin-op")
  of ast.nkUnaryOp:
    let v = eval(node.operand)
    case node.unaryOp
    of "-": -v
    else: raise newException(ValueError, "Unknown unary-op")