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
    print(tree.toStringTree(recog=parser))

    
    if parser.getNumberOfSyntaxErrors() > 0:
        print("failed")
    else:
        print("passed!")
        save_as_png(tree, parser)

def save_as_png(tree, parser):
    from antlr4.tree.Tree import Trees
    from antlr4.tree.Trees import get_tree_text

    lisp_tree_str = Trees.toStringTree(tree, None, parser)
    lisp_tree_str = lisp_tree_str.replace(" ", "").replace("\n", "")

    input_stream = InputStream(lisp_tree_str)
    lexer = PyParserLexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = PyParserParser(stream)

    tree = parser.prog()

    with open("tree.dot", "w") as dotfile:
        dotfile.write("digraph parse_tree {\n")
        _save_as_dot(tree, parser, dotfile, counter=1)
        dotfile.write("}\n")

    # Generate PNG from DOT file
    import subprocess
    subprocess.call(["dot", "-Tpng", "-O", "tree.dot"])

def _save_as_dot(tree, parser, dotfile, counter):
    for i in range(tree.getChildCount()):
        child = tree.getChild(i)
        dotfile.write(f"  node{counter} [label=\"{parser.ruleNames[tree.getRuleIndex()]}\\n{tree.getText()}\"];\n")
        dotfile.write(f"  node{counter} -> node{counter + 1};\n")
        counter = _save_as_dot(child, parser, dotfile, counter + 1)
    return counter

if __name__ == '__main__':
    main(sys.argv)
