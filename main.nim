import std/[terminal]
import lexer/lexer      as lexer
# import parser/parser    as parser
# import runtime/interpreter as intp


when isMainModule:
  # let path = paramStr(1)
  # if path == "":
  #   styledEcho fgRed, "Usage: fluxen <file.fc>"
  #   quit 1
  let code   = readFile("./examples/main.f")
  let tokens = lexer.tokenizer(code)
  
  # let asts    = parser.parse(tokens)

  
  try:
    for i in tokens:
      echo i
    # var env: intp.Env = initTable[string, int64]()
    # for n in asts:
    #   discard intp.eval(n, env)
  except ValueError as e:
    styledEcho fgRed, "Runtime error: ", e.msg