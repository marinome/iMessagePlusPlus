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
  /// Returns the available themes in the associated Highlightr package.
  public static var availableThemes =
    Highlightr()?.availableThemes().map(ThemeName.init).sorted() ?? []
  /// Returns the available languages in the associated Highlightr package.
  public static var availableLanguages =
    Highlightr()?.supportedLanguages().map(Language.init).sorted() ?? []
  /**
   * Flags available for `Lexer`, currently just:
   * - `.editable`
   * - `.selectable`
   */
  @frozen public struct Flags: OptionSet {
    public let rawValue : UInt8
    @inlinable public init(rawValue: UInt8) { self.rawValue = rawValue }
    
    /// `.editable` requires that the `source` of the `Lexer` is a
    /// `Binding`.
    public static let editable   = Flags(rawValue: 1 << 0)
    
    /// Whether the displayed content should be selectable by the user.
    public static let selectable = Flags(rawValue: 1 << 1)
    
    /// If the user starts a newline, the editor automagically adds the same
    /// whitespace as on the previous line.
    public static let smartIndent = Flags(rawValue: 1 << 2)
    
    public static let defaultViewerFlags : Flags = [ .selectable ]
    public static let defaultEditorFlags : Flags =
                        [ .selectable, .editable, .smartIndent ]
  }
  
  @frozen public enum IndentStyle: Equatable {
    case system
    case softTab(width: Int)
  }
  
  /**
   * Default auto pairing mappings for languages.
   */
  public static var defaultAutoPairs : [ Language : [ String : String ] ] = [
    .cpp: cStyleAutoPairs
  ]
  public static var cStyleAutoPairs = [
    "(": ")", "[": "]", "{": "}", "\"": "\"",  "'": "'", "`": "`"
  ]
  public static var xmlStyleAutoPairs = [ "<": ">", "\"": "\"", "'": "'" ]


  /**
   * Configures a Lexer View with the given parameters.
   *
   * - Parameters:
   *   - source:      A binding to a String that holds the source code to be
   *                  edited (or displayed).
   *   - selection:   A binding to the selected range of the `source`.
   *   - language:    Optionally set a language (e.g. `.swift`), otherwise
   *                  Highlight.js will attempt to detect the language.
   *   - theme:       The name of the theme to use, defaults to "pojoaque".
   *   - fontSize:    On macOS this Binding can be used to persist the size of
   *                  the font in use. At runtime this is combined with the
   *                  theme to produce the full font information. (optional)
   *   - flags:       Configure whether the text is editable and/or selectable
   *                  (defaults to both).
   *   - indentStyle: Optionally insert a configurable amount of spaces if the
   *                  user hits "tab".
   *   - autoPairs:   A mapping of open/close characters, where the close
   *                  characters are automatically injected when the user enters
   *                  the opening character. For example: `[ "{": "}" ]` would
   *                  automatically insert the closing "}" if the user enters
   *                  "{". If no value is given, the default mapping for the
   *                  language is used.
   *   - inset:       The editor can be inset in the scroll view. Defaults to
   *                  8/8.
   *   - autoscroll:  If enabled, the editor automatically scrolls to the respective
   *                  region when the `selection` is changed programatically.
   */
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
  {
    self.source      = source
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
  
  /**
   * Configures a read-only Lexer View with the given parameters.
   *
   * - Parameters:
   *   - source:      A String that holds the source code to be displayed.
   *   - language:    Optionally set a language (e.g. `.swift`), otherwise
   *                  Highlight.js will attempt to detect the language.
   *   - theme:       The name of the theme to use, defaults to "pojoaque".
   *   - fontSize:    On macOS this Binding can be used to persist the size of
   *                  the font in use. At runtime this is combined with the
   *                  theme to produce the full font information. (optional)
   *   - flags:       Configure whether the text is selectable
   *                  (defaults to both).
   *   - indentStyle: Optionally insert a configurable amount of spaces if the
   *                  user hits "tab".
   *   - autoPairs:   A mapping of open/close characters, where the close
   *                  characters are automatically injected when the user enters
   *                  the opening character. For example: `[ "{": "}" ]` would
   *                  automatically insert the closing "}" if the user enters
   *                  "{". If no value is given, the default mapping for the
   *                  language is used.
   *   - inset:       The editor can be inset in the scroll view. Defaults to
   *                  8/8.
   */
  @inlinable
  public init(source      : String,
              language    : Language?            = nil,
              theme       : ThemeName            = .default,
              fontSize    : Binding<CGFloat>?    = nil,
              flags       : Flags                = .defaultViewerFlags,
              indentStyle : IndentStyle          = .system,
              autoPairs   : [ String : String ]? = nil,
              inset       : CGSize?              = nil)
  {
    assert(!flags.contains(.editable), "Editing requires a Binding")
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
