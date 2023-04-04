//
//  UXCodeTextView.swift
//  iMessagePlusPlus
//
//  Created by MM, edited by MM
//

import Foundation
import Highlightr

import UIKit
typealias UXTextView          = UITextView
typealias UXTextViewDelegate  = UITextViewDelegate

//Subclass of NSTextView/UITextView which adds some code editing features to the respective Cocoa views.
final class UXCodeTextView: UXTextView {
    fileprivate let highlightr = Highlightr()
    private var hlTextStorage : CodeAttributedString? {
        return textStorage as? CodeAttributedString
    }
    //If the user starts a newline, the editor automagically adds the same whitespace as on the previous line.
    var isSmartIndentEnabled = true
    var indentStyle          = Lexer.IndentStyle.system {
        didSet {
            guard oldValue != indentStyle else { return }
            reindent(oldStyle: oldValue)
        }
    }
    var autoPairCompletion = [ String : String ]()
    var language : Lexer.Language? {
        set {
            guard hlTextStorage?.language != newValue?.rawValue else { return }
            hlTextStorage?.language = newValue?.rawValue
        }
        get { return hlTextStorage?.language.flatMap(Lexer.Language.init) }
    }
    private(set) var themeName = Lexer.ThemeName.default {
        didSet {
            highlightr?.setTheme(to: themeName.rawValue)
            if let font = highlightr?.theme?.codeFont { self.font = font }
        }
    }
    init() {
        let textStorage = highlightr.flatMap {
            CodeAttributedString(highlightr: $0)
        }
        ?? NSTextStorage()
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer()
        textContainer.widthTracksTextView  = true // those are key!
        layoutManager.addTextContainer(textContainer)
        super.init(frame: .zero, textContainer: textContainer)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func copy(_ sender: Any?) {
        guard let coordinator = delegate as? UXCodeTextViewDelegate else {
            assertionFailure("Expected coordinator as delegate")
            return super.copy(sender)
        }
        if coordinator.allowCopy { super.copy(sender) }
    }
    
    private var isAutoPairEnabled : Bool { return !autoPairCompletion.isEmpty }
    
#if os(iOS)
    override func insertText(_ text: String) {
        super.insertText(text)
        guard isAutoPairEnabled              else { return }
        guard let end = autoPairCompletion[text] else { return }
        let prev = self.selectedRange
        super.insertText(end)
        self.selectedRange = prev
    }
#endif
    private func reindent(oldStyle: Lexer.IndentStyle) {
        // - walk over the lines, strip and count the whitespaces
    }
    @discardableResult
    func applyNewFontSize(_ newSize: CGFloat) -> Bool {
        applyNewTheme(nil, andFontSize: newSize)
    }
    @discardableResult
    func applyNewTheme(_ newTheme: Lexer.ThemeName) -> Bool {
        guard themeName != newTheme else { return false }
        guard let highlightr = highlightr,
              highlightr.setTheme(to: newTheme.rawValue),
              let theme      = highlightr.theme else { return false }
        self.backgroundColor = theme.themeBackgroundColor
        if let font = theme.codeFont, font !== self.font { self.font = font }
        return true
    }
    @discardableResult
    func applyNewTheme(_ newTheme: Lexer.ThemeName? = nil,
                       andFontSize newSize: CGFloat) -> Bool{
        // Setting the theme reloads it (i.e. makes a "copy").
        guard let highlightr = highlightr,
              highlightr.setTheme(to: (newTheme ?? themeName).rawValue),
              let theme      = highlightr.theme else { return false }
        
        guard theme.codeFont?.pointSize != newSize else { return true }
        
        theme.codeFont       = theme.codeFont?      .withSize(newSize)
        theme.boldCodeFont   = theme.boldCodeFont?  .withSize(newSize)
        theme.italicCodeFont = theme.italicCodeFont?.withSize(newSize)
        self.backgroundColor = theme.themeBackgroundColor
        if let font = theme.codeFont, font !== self.font { self.font = font }
        return true
    }
}
protocol UXCodeTextViewDelegate: UXTextViewDelegate {
    var allowCopy : Bool     { get }
    var fontSize  : CGFloat? { get set }
}
// MARK: - Smarts as shown in https://github.com/naoty/NTYSmartTextView
extension UXTextView {
    var swiftSelectedRange : Range<String.Index> {
        let s = self.string
        guard !s.isEmpty else { return s.startIndex..<s.startIndex }
        guard let selectedRange = Range(self.selectedRange, in: s) else {
            assertionFailure("Could not convert the selectedRange?")
            return s.startIndex..<s.startIndex
        }
        return selectedRange
    }
    fileprivate var currentLine: String {
        let s = self.string
        return String(s[s.lineRange(for: swiftSelectedRange)])
    }
    fileprivate var isEndOfLine : Bool {
        let ( _, isEnd ) = getStartOrEndOfLine()
        return isEnd
    }
    fileprivate var isStartOrEndOfLine : Bool {
        let ( isStart, isEnd ) = getStartOrEndOfLine()
        return isStart || isEnd
    }
    fileprivate func getStartOrEndOfLine() -> ( isStart: Bool, isEnd: Bool ) {
        let s             = self.string
        let selectedRange = self.swiftSelectedRange
        var lineStart = s.startIndex, lineEnd = s.endIndex, contentEnd = s.endIndex
        string.getLineStart(&lineStart, end: &lineEnd, contentsEnd: &contentEnd,
                            for: selectedRange)
        return ( isStart : selectedRange.lowerBound == lineStart,
                 isEnd   : selectedRange.lowerBound == lineEnd )
    }
}
extension UITextView {
    var string : String { // NeXTstep was right!
        set { text = newValue}
        get { return text }
    }
    var codeTextStorage : NSTextStorage? { return textStorage }
}
