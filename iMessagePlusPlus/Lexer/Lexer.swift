//
//  Lexer.swift
//  iMessagePlusPlus
//
//  Created by MM, edited by MM and SP
//

import Foundation
import SwiftUI
import Highlightr

//Lexer.availableLanguages
//Lexer.availableThemes
//Lexer(source: $source, language: language,flags: [ .selectable, .editable, .smartIndent ])
//Lexer(source: $source, language: language, indentStyle: .softTab(width: 2))

/*struct ContentView: View {
 static private let initialSource = "let a = 42\n"
 
 @State private var source = Self.initialSource
 @State private var selection = Self.initialSource.endIndex..<Self.initialSource.endIndex
 
 var body: some View {
 Lexer(source: $source,
 selection: $selection,
 language: .swift,
 theme: .ocean,
 autoscroll: false)
 Button("Select All") {
 selection = source.startIndex..<source.endIndex
 }
 }
 }*/

public struct Lexer: View {
    public static var availableThemes = Highlightr()?.availableThemes().map(ThemeName.init).sorted() ?? []
    public static var availableLanguages = Highlightr()?.supportedLanguages().map(Language.init).sorted() ?? []
    //flags: .editable or .selectable
    @frozen public struct Flags: OptionSet {
        public let rawValue : UInt8
        @inlinable public init(rawValue: UInt8) { self.rawValue = rawValue }
        public static let editable   = Flags(rawValue: 1 << 0)
        public static let selectable = Flags(rawValue: 1 << 1)
//If the user starts a newline, the editor automagically adds the same whitespace as on the previous line.
        public static let smartIndent = Flags(rawValue: 1 << 2)
        public static let defaultViewerFlags : Flags = [ .selectable ]
        public static let defaultEditorFlags : Flags = [ .selectable, .editable, .smartIndent ]
    }
    
    @frozen public enum IndentStyle: Equatable {
        case system
        case softTab(width: Int)
    }
    
    //cpp maps for pairs
    public static var defaultAutoPairs : [ Language : [ String : String ] ] = [.cpp: cStyleAutoPairs]
    public static var cStyleAutoPairs = ["(": ")", "[": "]", "{": "}", "\"": "\"",  "'": "'", "`": "`"]
    public static var xmlStyleAutoPairs = [ "<": ">", "\"": "\"", "'": "'" ]
    //Lexer params: source, selection, language, theme, fontSize, flags, indentStyle, autoPairs, inset, autosccroll
    public init(source      : Binding<String>,
                selection   : Binding<Range<String.Index>>? = nil,
                language    : Language?            = nil,
                theme       : ThemeName            = .default,
                fontSize    : Binding<CGFloat>?    = nil,
                flags       : Flags                = .defaultEditorFlags,
                indentStyle : IndentStyle          = .system,
                autoPairs   : [ String : String ]? = nil,
                inset       : CGSize?              = nil,
                autoscroll  : Bool                 = true)
    {   self.source      = source
        self.selection   = selection
        self.fontSize    = fontSize
        self.language    = language
        self.themeName   = theme
        self.flags       = flags
        self.indentStyle = indentStyle
        self.inset       = inset ?? CGSize(width: 8, height: 8)
        self.autoPairs   = autoPairs
        ?? language.flatMap({ Lexer.defaultAutoPairs[$0] })
        ?? [:]
        self.autoscroll = autoscroll
    }
    
    //same thing as above but read only
    @inlinable
    public init(source      : String,
                language    : Language?            = nil,
                theme       : ThemeName            = .default,
                fontSize    : Binding<CGFloat>?    = nil,
                flags       : Flags                = .defaultViewerFlags,
                indentStyle : IndentStyle          = .system,
                autoPairs   : [ String : String ]? = nil,
                inset       : CGSize?              = nil)
    { assert(!flags.contains(.editable), "Editing requires a Binding")
        self.init(source      : .constant(source),
                  language    : language,
                  theme       : theme,
                  fontSize    : fontSize,
                  flags       : flags.subtracting(.editable),
                  indentStyle : indentStyle,
                  autoPairs   : autoPairs,
                  inset       : inset)
    }
    private var source      : Binding<String>
    private var selection   : Binding<Range<String.Index>>?
    private var fontSize    : Binding<CGFloat>?
    private let language    : Language?
    private let themeName   : ThemeName
    private let flags       : Flags
    private let indentStyle : IndentStyle
    private let autoPairs   : [ String : String ]
    private let inset       : CGSize
    private let autoscroll  : Bool
    
    public var body: some View {
        UXCodeTextViewRepresentable(source      : source,
                                    selection   : selection,
                                    language    : language,
                                    theme       : themeName,
                                    fontSize    : fontSize,
                                    flags       : flags,
                                    indentStyle : indentStyle,
                                    autoPairs   : autoPairs,
                                    inset       : inset,
                                    autoscroll  : autoscroll)
    }
}

struct Lexer_Previews: PreviewProvider {
    static var previews: some View {
        Lexer(source: "let a = 5")
            .frame(width: 200, height: 100)
        Lexer(source: "let a = 5", language: .cpp, theme: .pojoaque)
            .frame(width: 200, height: 100)
    }
}
