//
//  Theme.swift
//  iMessagePlusPlus
//
//  Created by MM, edited by MM and SP
//

import Foundation
public extension Lexer {
    @frozen
    struct ThemeName: TypedString {
        public let rawValue : String
        @inlinable
        public init(rawValue: String) { self.rawValue = rawValue }
    }
}

public extension Lexer.ThemeName {
    static var imessageplusplus = Lexer.ThemeName(rawValue: "imessageplusplus")
    //static var `default` = imessageplusplus
    static var `default` = pojoaque
    static var pojoaque  = Lexer.ThemeName(rawValue: "pojoaque")
    static var agate     = Lexer.ThemeName(rawValue: "agate")
    static var ocean     = Lexer.ThemeName(rawValue: "ocean")
    static var atelierSavannaLight = Lexer.ThemeName(rawValue: "atelier-savanna-light")
    static var atelierSavannaDark = Lexer.ThemeName(rawValue: "atelier-savanna-dark")
}
