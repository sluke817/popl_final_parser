import sys
from antlr4 import *
from PyParserLexer import PyParserLexer
from PyParserParser import PyParserParser
#from VisitorInterp import VisitorInterp

def main(argv): 
    input_stream = FileStream(argv[1])
    lexer = PyParserLexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = PyParserParser(stream)
    tree = parser.prog()
    #print(tree.toStringTree(recog=parser))
    if parser.getNumberOfSyntaxErrors() > 0:
        print("failed")
    else:
        print("passed!")

if __name__ == '__main__':
    main(sys.argv)
