
type
  TokenKind* = enum
    # Literals
    TokenLiteralInteger
    TokenLiteralFloat
    TokenLiteralString
    TokenLiteralBoolean

    # Identifiers
    TokenIdentifier

    # Keywords
    TokenKeywordPrint
    TokenKeywordInfer
    TokenKeywordFunction
    TokenKeywordIf
    TokenKeywordElse
    TokenKeywordWhile
    TokenKeywordFor
    TokenKeywordReturn

    # Operators
    TokenOperatorAddition
    TokenOperatorSubtraction
    TokenOperatorMultiplication
    TokenOperatorDivision
    TokenOperatorAssignment
    TokenOperatorEquality
    TokenOperatorInequality
    TokenOperatorGreaterThan
    TokenOperatorGreaterThanOrEqual
    TokenOperatorLessThan
    TokenOperatorLessThanOrEqual

    # Symbols / Punctuation
    TokenSymbolParenthesisOpen
    TokenSymbolParenthesisClose
    TokenSymbolBraceOpen
    TokenSymbolBraceClose
    TokenSymbolBracketOpen
    TokenSymbolBracketClose
    TokenSymbolComma
    TokenSymbolColon
    TokenSymbolDoubleColon
    TokenSymbolSemicolon
    TokenSymbolDot

    # Special
    TokenEndOfFile
    TokenUnknown
    TokenNewline

  TokenObject* = object
    kind*: TokenKind
    value*: string
    lineNumber*: int
    columnNumber*: int
