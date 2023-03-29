//
//  Lexer.swift
//  iMessage
//
//  Created by MM & SP
//

import SwiftUI
import UIKit

enum TokenType {
    case keyword
    case identifier
    case number
    case string
    case comment
}

/*struct Token {
    //let type: TokenType
    let range: Range<String.Index>//m_white
    let color: UIColor
}*/

class Token {
    var type: TokenType
    var value: String
    
    init(type: TokenType, value: String) {
        self.type = type
        self.value = value
    }
}

// Define a lexer class that can tokenize a string of input
// Combined alternative into one for build purposes - MM

class Lexer {
    let input: String
    var currentIndex: String.Index
    var currentChar: Character?
    //var tokens: [Token] = []
    
    // Initialize the lexer with the input string
    init(input: String) {
        self.input = input
        self.currentIndex = input.startIndex
    }
    
    // Move the current index and current character forward by one
    func advance() {
        if currentIndex < input.endIndex {
            currentIndex = input.index(after: currentIndex)
            currentChar = input[currentIndex]
        } else {
            currentChar = nil
        }
    }
    
    // Peek at the next character in the input string without advancing
    func peek() -> Character? {
        let peekIndex = input.index(after: currentIndex)
        if peekIndex < input.endIndex {
            return input[peekIndex]
        } else {
            return nil
        }
    }
    
    // Tokenize the input string and return an array of tokens
    func tokenize() -> [Token] {
        var tokens = [Token]()
        while currentIndex < input.endIndex {
            if let char = currentChar {
                if char.isWhitespace {
                    advance()
                } else if char.isLetter {
                    let value = readIdentifier()
                    let type = checkType(identifier: value)
                    tokens.append(Token(type: type, value: value))
                } else if char.isNumber {
                    _ = readNumber()
                    //tokens.append(Token(type: .constant, value: value))
                } else if char == "\"" {
                    let value = readString()
                    tokens.append(Token(type: .string, value: value))
                } else if "+-*/%".contains(char) {
                    advance()
                    //tokens.append(Token(type: .operator, value: String(char)))
                } else {
                    advance()
                }
            }
        }
        return tokens
    }
    
    // Read an identifier from the input string
    private func readIdentifier() -> String {
        var value = ""
        while let char = currentChar, char.isLetter, char.isNumber {
            value.append(char)
            advance()
        }
        return value
    }
    
    // Read a number from the input string
    private func readNumber() -> String {
        var value = ""
        while let char = currentChar, char.isNumber {
            value.append(char)
            advance()
        }
        return value
    }
    
    // Read a string from the input string
    private func readString() -> String {
        advance()
        var value = ""
        while let char = currentChar, char != "\"" {
            value.append(char)
            advance()
        }
        advance()
        return value
    }
    
    // Check the type of an identifier and return the appropriate TokenType
    private func checkType(identifier: String) -> TokenType {
        switch identifier {
        case "int", "float", "double", "char":
            return .keyword
        default:
            return .identifier
        }
    }
    
    let keywordColors: [String: UIColor] = [:
            /*let m_white = Color(red: 246/255, green: 246/255, blue: 246/255),
            let m_black = Color(red: 30/255, green: 30/255, blue: 31/255),
            let m_lightgray = Color(red: 202/255, green: 204/255, blue: 210/255),
            let m_rose = Color(red: 234/255, green: 66/255, blue: 143/255),
            let m_red = Color(red: 233/255, green: 64/255, blue: 47/255),
            let m_yellow = Color(red: 223/255, green: 253/255, blue: 82/255),
            let m_lizardgreen = Color(red: 174/255, green: 250/255, blue: 78/255),
            let m_springgreen = Color(red: 116/255, green: 251/255, blue: 175/255),
         let m_blue = Color(red: 102/255, green: 221/255, blue: 239/255),
            "int": .m_white,
            "float": .m_white,
            "double": .m_white,
            "char": .m_white,
            "bool": .m_white,
            "void": .m_white,
            "class": .m_black,
            "struct": .m_black,
            "enum": .m_black,
            "typedef": .m_black,
            "template": .m_black,
            "namespace": .m_black,
            "using": .m_black,
            "return": .m_lizardgreen,
            "if": .m_lizardgreen,
            "else": .m_lizardgreen,
            "switch": .m_lizardgreen,
            "case": .m_lizardgreen,
            "default": .m_lizardgreen,
            "while": .m_lizardgreen,
            "do": .m_lizardgreen,
            "for": .m_lizardgreen,
            "break": .m_lizardgreen,
            "continue": .m_lizardgreen,
            "goto": .m_lizardgreen,
            "new": .m_red ,
            "delete": .m_red ,
            "operator": .m_red ,
            "sizeof": .m_red ,
            "true": .m_springgreen,
            "false": .m_springgreen,
            "nullptr": .m_springgreen,
            "static_cast": .m_red ,
            "const_cast": .m_red ,
            "dynamic_cast": .m_red ,
            "reinterpret_cast": .m_red ,
            "public": .m_yellow,
            "private": .m_yellow,
            "protected": .m_yellow,
            "virtual": .m_yellow,
            "override": .m_yellow,
            "final": .m_yellow,
            "friend": .m_yellow,*/
    ]
    
    /// Advances the current index and sets the current character to the next character in the input string.
    /*func advance() {
        guard currentIndex < input.endIndex else {
            currentChar = nil
            return
        }
        currentChar = input[currentIndex]
        currentIndex = input.index(after: currentIndex)
    }*/
    
    /// Skips over any white space and comments in the input string.
    func skipWhiteSpaceAndComments() {
        while let char = currentChar {
            if char.isWhitespace {
                advance()
            } else if char == "/" && input[currentIndex..<input.index(after: currentIndex)] == "//" {
                skipSingleLineComment()
            } else if char == "/" && input[currentIndex..<input.index(after: currentIndex)] == "/*" {
                skipMultiLineComment()
            } else {
                break
            }
        }
    }
    
    /// Skips over a single line comment in the input string.
    func skipSingleLineComment() {
        advance()
        advance()
        
        while let char = currentChar, char != "\n" {
            advance()
        }
    }
    
    /// Skips over a multi-line comment in the input string.
    func skipMultiLineComment() {
        advance()
        advance()
        
        while let char = currentChar {
            if char == "*" && input[currentIndex..<input.index(after: currentIndex)] == "/" {
                advance()
                advance()
                break
            } else {
                advance()
            }
        }
    }
}

// Highlight the types in an input string by returning an attributed string with appropriate colors
/*func highlightTypes(input: String) -> NSAttributedString {
    let lexer = Lexer(input: input)
    let tokens = lexer.tokenize()
    let result = NSMutableAttributedString(string: "")
}*/
