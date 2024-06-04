# -*- coding: utf-8 -*-
from pygments.lexer import ExtendedRegexLexer, bygroups, words, include
from pygments.token import *

import re


__all__ = ['GCodeLexer']

class GCodeLexer(ExtendedRegexLexer):
    """
    Lexer for gCode

    """
    name = 'gCodeLexer'
    aliases = ['g_code']


    fileextensions = ['apt', 'cnc', 'din', 'dnc', 'ecs', 'eia', 'fan', 
                      'fgc', 'fnc', 'gc', 'gcd', 'GCD', 'gcode', 'hnc', 
                      'i', 'maz', 'min', 'mpf', 'mpr', 'nc', 'NC', 'ncc', 
                      'ncf', 'ncg', 'ncp', 'ngc', 'pim', 'plt', 'ply', 'prg', 
                      'ptp', 'rol', 'sbp', 'tap', 'xpi']

    filenames = ['*.' + ext for ext in fileextensions] 

    # Builtin words
    builtins = (
        'IF', 'END', 'endif', 'end_if',
        'THEN', 'else', 'elsif',
        'WHILE', 'DO', 'endwhile', 'end_while',
        'exit',
        'sub', 'endsub', 'end_sub',
        'call',
        'repeat', 'endrepeat', 'end_repeat', 'until'
    )

    # Build in math functions
    functions = (
        'AND', 'OR','XOR',
        'EQ', 'NE', 'GT', 'GE', 'LT', 'LE',
        'MOD',
        'COS', 'SIN', 'TAN', 'ACOS', 'ASIN', 'ATAN',
        'ABS', 'ROUND', 'FIX', 'FUP', 'exists',
        'EXP', 'LN', 'SQRT'
    )

    tokens = {
        'root': [
            
            # multi-line comments. Only for
            (r';', Comment.Multiline, 'comment'),
            (r'\(', Comment.Multiline, 'par_comment'),
            (r'\([^\n\r]*\)', Comment.SingleLine),

            # Braced expressions entry point
            (r'(\[)', Keyword, 'bracket1'),

            # math functions, math case-insensitive
            (r'[-+*/:=]', Operator),
            ("(?i)(%s)" % '|'.join(re.escape(entry) for entry in functions), Operator.Word),

            # built in commands, match case-insensitive
            ("(?i)(%s)" % '|'.join(re.escape(entry) for entry in builtins), Name.Builtin),

            # Coordinates, Feeds, Speeds, and Machining parameter, 
            # match only the label
            (r'(?<![a-zA-Z\<])(GOTO08)\d*', Keyword.Pseudo.Error),
            (r'(?<![a-zA-Z\<])(N08)\d*', Keyword.Pseudo.Error),
            (r'(?<![a-zA-Z\<])(N|GOTO)\d*', Keyword.Pseudo),
            # G and M commands and other tooling, match only the label
            (r'(?<![a-zA-Z\<])[ABCDEHIJKQRUVWXYZ](?=(\d+\.?\d?))+', Operator),
            (r'(?<![a-zA-Z\<])[M]\d*\.\d+', Number),
            (r'(?<![a-zA-Z\<])[GM]\d*', Keyword.Pseudo.Declaration),
            (r'(?<![a-zA-Z\<])[T]\d*\.\d+', Number),
            (r'(?<![a-zA-Z\<])[T]\d*', Keyword.Pseudo.Tool),
            (r'(?<![a-zA-Z\<])[FS]\d*\.\d+', Number),
            (r'(?<![a-zA-Z\<])[FS]\d*', Keyword.Pseudo.Speed),
            # (r'(?<![a-zA-Z\<])[FS\^\@](?=(\s*[+-]?\d*\.?\d+|\s*[+-]?#))', Keyword.Type),
            # Line numbers
            (r'\s*[n]\d+', Comment),
            (r'(?<![a-zA-Z\<])[L]\d*', Keyword.Pseudo.Reserved),

            # Non-persistent Arguments (#1-#30)
            (r'(?<=#)0*[1-3]?[0-9](?=\D)', Name.Variable.Magic),
            # Numbered Variables
            (r'(?<=#)0*[4-9]?[0-9]{1,5}', Name.Variable),
            # Local Variables
            (r'(?<=#\<)\w[\w_]*(?=\>)', Name.Variable),
            # GlobalVariables
            (r'(?<=#\<)_[\w_]*(?=\>)',Name.Variable.Global),

            # Variables Indicator
            (r'(#|\<|\>)', Name.Variable),

            # Subroutines, match label
            (r'(?<![a-zA-Z\<])[OP]\d*', Keyword.Pseudo.Reserved),
            # Subroutines, named, match function name
            (r'(?<=([OP][\<\[]))\w+(?=\>)', Name.Function),

            # OTHERS
            include('data')

        ],
        'data':[
            (r'\s+', Text),
            (r'\d?\.\d+', Number.Float),
            (r'\d+', Number.Integer),
            (r'\w+', Text),
        ],
        'par_comment':[
            (r'[^()]', Comment.Multiline),
            (r'\(', Comment.Multiline, '#push'),
            (r'\)', Comment.Multiline, '#pop'),
            (r'\)', Comment.Multiline),
        ],
        'comment':[
            (r'.*;.*$', Comment.Multiline, '#pop'),
            (r'^.*\n', Comment.Multiline),
            (r'.', Comment.Multiline),
        ],

        'bracket1': [
            (r'\[', Keyword, 'bracket2'),
            (r'\]', Keyword, '#pop'),
            include('root')
        ],
        'bracket2': [
            (r'\[', Keyword, 'bracket3'),
            (r'\]', Keyword, '#pop'),
            include('root')
        ],
        'bracket3': [
            (r'\]', Keyword, '#pop'),
            include('root')
        ],
    }
