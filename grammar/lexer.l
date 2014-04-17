%{

#include <QString>
#include "lexer.hpp"

extern int lineNumber;

typedef Language::Parser::token token;

#define yyterminate() return( token::END )
#define YY_NO_UNISTD_H // For msvc

%}

%option debug
%option yyclass="Lexer"
%option noyywrap
%option c++

%%


[ \t]+          				; /* Ignore white space */
[\n]            				{ lineNumber++; }

\{\{(.)*\}\} ;

\"(\\.|[^"])*\" 				{
                                                        yylval->sval = new QString( yytext );
                                                        return token::String;
                                                }

([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)	{
                                                        yylval->dval = atoi(yytext);
                                                        return token::Number;
                                                }

"Praise the lord!" { return token::BEGIN_SCOPE; }
"Hallelujah!" { return token::END_SCOPE; }
"and also" { return token::SEPARATOR; }
"with" {return token::ARGUMENT_PROLOG;}
"call upon" {return token::FUNCTION_CALL_PROLOG;}
"as an offering" {return token::FUNCTION_CALL_EPILOG;}
", please accept" {return token::EXPRESSION_PROLOG;}
"let" 					{ return token::PRINT; }
"be written" {return token::PRINT_EPILOG;}
"is now" {return token::ASSIGN;}

"and" {return token::ADD;}
"without" {return token::SUB;}
"added " {return token::MUL;}
                                                        "subtracted" {return token::DIV;}
"times" {return token::MUL_DIV_EPILOG;}

"numeral"					{ return token::NumberType; }
"text"	 					{ return token::TextType; }
"eternal void" 						{ return token::VoidType; }
"given that"						{ return token::IF; }
"...but, but... what if... ?" 						{ return token::ELSE; }
"as long as" 					{ return token::While; }
"return"  					{ return token::RETURN; }
"is the equal of" 						{ return token::EQ; }
"is a different beast than" 						{ return token::NE; }
"is superior to or the equal of" 						{ return token::GE; }
"is inferior to or the equal of" 						{ return token::LE; }
"is inferior to" {return token::LT; }
"is superior to" {return token::GT; }



[a-z|A-Z]([a-z|A-Z|0-9]+)?   			{
                                                        yylval->sval = new QString( yytext );
                                                        return( token::Identifier );
                                                }

. { return yytext[0];}

%%
