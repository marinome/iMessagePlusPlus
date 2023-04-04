//
//  Language.swift
//  iMessagePlusPlus
//
//  Created by MM, edited by MM and SP
//

import Foundation
public extension Lexer {
    @frozen
    struct Language: TypedString {
        public let rawValue : String
        @inlinable
        public init(rawValue: String) { self.rawValue = rawValue }
    }
}

public extension Lexer.Language {static var cpp = Lexer.Language(rawValue: "cpp")}
