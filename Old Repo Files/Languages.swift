//
//  Languages.swift
//  iMessage
//
//  Created by Morgan Marino on 3/22/23.
//

import Foundation

let languages: [String: [String: Any]] = [
    "C++": cppLanguage,
]

let cppLanguage: [String: Any] = [
    /*FORMAT:
     "...": [ //category name
        "regex": ..., //regex used for highlighting
        "group": 0, //regex group that should be highlighted
        "relevance": ..., //relevance over other tokens (1-10ish)
        "options": [], //regular expressions options
        "multiline": ... //if token is multiline (true/false)
      ],
     */
    "directives": [ //blue
        "regex": "\\b(include)\\b",
        "group": 0,
        "relevance": 1,
        "options": [],
        "multiline": false
    ],
    "parenthesis": [ //blue
        "regex": "(?<!:)\\(.*?(?<!\\))",
        "group": 0,
        "relevance": 1,
        "options": [],
        "multiline": false
    ],
    "keywords/identifiers": [ //springgreen
        "regex": "\\b(break|case|catch|class|double|else|false|float|for|if|int|namespace|open|operator|override|private|public|return|static|struct|switch|throw|true|try|using|while)\\b",
        "group": 0,
        "relevance": 2,
        "options": [],
        "multiline": false
    ],
    "numbers": [ //red
        "regex": "(?<=(\\s|\\[|,|:))([-]*\\d|\\.|_)+",
        "group": 0,
        "relevance": 0,
        "options": [],
        "multiline": false
    ],
    "strings": [ //lizardgreen
        "regex": #"(?<!\\)".*?(?<!\\)""#,
        "group": 0,
        "relevance": 3,
        "options": [],
        "multiline": false
    ],
    "comments": [ //lightgray
        "regex": "(?<!:)\\/\\/.*?(\n|$)",
        "group": 0,
        "relevance": 5,
        "options": [],
        "multiline": false
    ],
    //"background": //black
    //"default": //white
    //"functions": //yellow
    //"libraries": //rose
]
