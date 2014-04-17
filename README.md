Language
========

Language framework demo (flex/bison) + AST, symbol table and interpreter.

Tested with flex 2.5.35 Apple(flex-31), GNU Bison 3.0, Qt 4.8.4 and compiled with Clang (Apple LLVM version 5.1 (clang-503.0.38))

Run qmake -t vcapp to create makefiles for your target platform (You should be able to compile this on any halfway C++11 compliant compiler)

Build steps (mac):

1) qmake qmake scripture.pro -r -spec macx-clang CONFIG+=declarative_debug
2) lex -o grammar/lexer.y.cpp grammar/lexer.l
3) bison -d -o parser.tab.cpp -v grammar/parser.y
4) make


