import std/cmdline,os

# reading args
var fileLocation: string = paramStr(1)

# reading file
when isMainModule:
   var str: string = readFile(fileLocation)
   echo str