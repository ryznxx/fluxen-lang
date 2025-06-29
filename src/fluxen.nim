import std/[cmdline, os, strformat]

# ambil file path dari argumen
var fileLocation: string = paramStr(1)

# tracking posisi
var line = 1
var column = 1

when isMainModule:
  let content = readFile(fileLocation)
  
  for i, c in content:
    # print posisi + karakter
    echo &"({line}:{column}) '{c}'"

    # newline handling
    if c == '\n':
      line += 1
      column = 1
    else:
      column += 1
