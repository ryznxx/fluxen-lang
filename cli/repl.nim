import std/rdstdin
import lexer/lexer
# import parser/parser
# import runtime/interpreter

proc startRepl*() =
  echo "Fluxen REPL v0.1.0"
  while true:
    let line = readLineFromStdin(">>> ")
    if line == "exit": break
    let tokens = lexer.tokenizer(line)
    # let ast    = parser.parse(tokens)
    # let result = interpreter.eval(ast)
    echo result