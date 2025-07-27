import std/os
import lexer/lexer as lexer
import parser/parser as parser
import runtime/interpreter as intp

when isMainModule:
  let path = paramStr(1)
  if path == "":
    echo "You need specify filename"
  else:
    let code = readFile(path)
    let tokens = lexer.tokenizer(code)
    let astRoot = parser.parse(tokens)
    # echo astRoot.repr()
    echo intp.eval(astRoot) 
    for i in tokens:
      echo i