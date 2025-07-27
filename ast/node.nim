type
  NodeKind* = enum
    nkIntLit
    nkBinOp
    nkUnaryOp

  Node* = ref object
    case kind*: NodeKind
    of nkIntLit:
      value*: int64
    of nkBinOp:
      binOp*: string     # ⬅️ ubah jadi binOp
      left*, right*: Node
    of nkUnaryOp:
      unaryOp*: string   # ⬅️ ubah jadi unaryOp
      operand*: Node