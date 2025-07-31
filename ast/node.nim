type
  NodeKind* = enum
    # sudah ada
    nkIntLit
    nkBinOp
    nkUnaryOp
    nkVarDecl

    # ---------- baru ----------
    nkIdent            # penggunaan variabel: x
    nkPrint            # print expr
    nkIf               # if cond { body }
    nkBlock            # { stmt* }
    nkFunctionDecl     # func name(...) => type { body }
    nkCall             # name(args...)
    nkReturn           # return expr

  Node* = ref object
    case kind*: NodeKind
    of nkIntLit:
      value*: int64
    of nkBinOp:
      binOp*: string
      left*, right*: Node
    of nkUnaryOp:
      unaryOp*: string
      operand*: Node
    of nkVarDecl:
      varName*: string
      valueExpr*: Node

    # ---------- baru ----------
    of nkIdent:
      name*: string
    of nkPrint:
      expr*: Node
    of nkIf:
      cond*, thenBody*, elseBody*: Node   # else bisa nil
    of nkBlock:
      stmts*: seq[Node]                  # list statement
    of nkFunctionDecl:
      funcName*: string
      params*: seq[string]
      returnType*: string   # optional
      body*: Node
    of nkCall:
      callee*: Node
      args*: seq[Node]
    of nkReturn:
      retExpr*: Node         # bisa nil untuk void