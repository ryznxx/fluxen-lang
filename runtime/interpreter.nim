# import std/tables
# import "../ast/node" as ast

# type Env* = Table[string, int64]

# proc eval*(node: ast.Node; env: var Env): int64 =
#   case node.kind
#   of ast.nkIntLit:
#     node.value
#   of ast.nkIdent:
#     if not env.hasKey(node.name):
#       raise newException(ValueError, "Undeclared variable: " & node.name)
#     env[node.name]
#   of ast.nkBinOp:
#     let l = eval(node.left, env)
#     let r = eval(node.right, env)
#     case node.binOp
#     of "+": l + r
#     of "-": l - r
#     of "*": l * r
#     of "/": l div r
#     else: raise newException(ValueError, "Unknown bin-op")
#   of ast.nkUnaryOp:
#     let v = eval(node.operand, env)
#     case node.unaryOp
#     of "-": -v
#     else: raise newException(ValueError, "Unknown unary-op")
#   of ast.nkVarDecl:
#     let val = eval(node.valueExpr, env)
#     env[node.varName] = val
#     val
#   # ---------- stub ----------
#   of ast.nkPrint:
#     raise newException(ValueError, "print belum diimplementasikan")
#   of ast.nkIf:
#     raise newException(ValueError, "if belum diimplementasikan")
#   of ast.nkBlock:
#     raise newException(ValueError, "block belum diimplementasikan")
#   of ast.nkFunctionDecl:
#     raise newException(ValueError, "function belum diimplementasikan")
#   of ast.nkCall:
#     raise newException(ValueError, "call belum diimplementasikan")
#   of ast.nkReturn:
#     raise newException(ValueError, "return belum diimplementasikan")