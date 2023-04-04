//
//  UXCodeTextViewRepresentable.swift
//  iMessagePlusPlus
//
//  Created by MM, edited by MM
//

import Foundation
import SwiftUI

typealias UXViewRepresentable = UIViewRepresentable
//gets stuff out of main representable -MM
struct UXCodeTextViewRepresentable : UXViewRepresentable {
    //Lexer View Params: source, language, theme, fontSize, flags, indentStyle, inset, autoPairs, autoscroll
    public init(source      : Binding<String>,
                selection   : Binding<Range<String.Index>>?,
                language    : Lexer.Language?,
                theme       : Lexer.ThemeName,
                fontSize    : Binding<CGFloat>?,
                flags       : Lexer.Flags,
                indentStyle : Lexer.IndentStyle,
                autoPairs   : [ String : String ],
                inset       : CGSize,
                autoscroll  : Bool)
    {
        self.source      = source
        self.selection = selection
        self.fontSize    = fontSize
        self.language    = language
        self.themeName   = theme
        self.flags       = flags
        self.indentStyle = indentStyle
        self.autoPairs   = autoPairs
        self.inset       = inset
        self.autoscroll = autoscroll
    }
    
    private var source      : Binding<String>
    private var selection   : Binding<Range<String.Index>>?
    private var fontSize    : Binding<CGFloat>?
    private let language    : Lexer.Language?
    private let themeName   : Lexer.ThemeName
    private let flags       : Lexer.Flags
    private let indentStyle : Lexer.IndentStyle
    private let inset       : CGSize
    private let autoPairs   : [ String : String ]
    private let autoscroll  : Bool
    
    // The inner `value` is true, exactly when execution is inside
    // the `updateTextView(_:)` method. The `Coordinator` can use this
    // value to guard against update cycles.
    // This needs to be a `State`, as the `UXCodeTextViewRepresentable`
    // might be destructed and recreated in between calls to `makeCoordinator()`
    // and `updateTextView(_:)`.
    @State private var isCurrentlyUpdatingView = ReferenceTypeBool(value: false)
    
    public final class Coordinator: NSObject, UXCodeTextViewDelegate {
        var parent : UXCodeTextViewRepresentable
        var fontSize : CGFloat? {
            set { if let value = newValue { parent.fontSize?.wrappedValue = value } }
            get { parent.fontSize?.wrappedValue }
        }
        init(_ parent: UXCodeTextViewRepresentable) {
            self.parent = parent
        }
#if os(iOS)
        public func textViewDidChange(_ textView: UITextView) {
            textViewDidChange(textView: textView)
        }
#else
#error("Unsupported OS")
#endif
        private func textViewDidChange(textView: UXTextView) {
            // This function may be called as a consequence of updating the text string
            //  in UXCodeTextViewRepresentable/updateTextView(_:)`.
            // Since this function might update the `parent.source` `Binding`, which in
            // turn might update a `State`, this would lead to undefined behavior.
            // (Changing a `State` during a `View` update is not permitted).
            guard !parent.isCurrentlyUpdatingView.value else {
                return
            }
            parent.source.wrappedValue = textView.string
        }
        
#if os(iOS)
        public func textViewDidChangeSelection(_ textView: UITextView) {
            textViewDidChangeSelection(textView: textView as! UXCodeTextView)
        }
#else
#error("Unsupported OS")
#endif
        
        private func textViewDidChangeSelection(textView: UXCodeTextView) {
            // This function may be called as a consequence of updating the selected
            // range in UXCodeTextViewRepresentable/updateTextView(_:)`.
            // Since this function might update the `parent.selection` `Binding`, which in
            // turn might update a `State`, this would lead to undefined behavior.
            // (Changing a `State` during a `View` update is not permitted).
            guard !parent.isCurrentlyUpdatingView.value else {
                return
            }
            guard let selection = parent.selection else {
                return
            }
            let range = textView.swiftSelectedRange
            if selection.wrappedValue != range {
                selection.wrappedValue = range
            }
        }
        var allowCopy: Bool {
            return parent.flags.contains(.selectable)
            || parent.flags.contains(.editable)
        }
    }
    public func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    private func updateTextView(_ textView: UXCodeTextView) {
        isCurrentlyUpdatingView.value = true
        defer {
            isCurrentlyUpdatingView.value = false
        }
        if let binding = fontSize {
            textView.applyNewTheme(themeName, andFontSize: binding.wrappedValue)
        }
        else {
            textView.applyNewTheme(themeName)
        }
        textView.language = language
        textView.indentStyle          = indentStyle
        textView.isSmartIndentEnabled = flags.contains(.smartIndent)
        textView.autoPairCompletion   = autoPairs
        if source.wrappedValue != textView.string {
            if let textStorage = textView.codeTextStorage {
                textStorage.replaceCharacters(in   : NSMakeRange(0, textStorage.length), with : source.wrappedValue)
            }
            else {
                assertionFailure("no text storage?")
                textView.string = source.wrappedValue
            }
        }
        if let selection = selection {
            let range = selection.wrappedValue
            
            if range != textView.swiftSelectedRange {
                let nsrange = NSRange(range, in: textView.string)
#if os(iOS)
                textView.selectedRange = nsrange
#else
#error("Unsupported OS")
#endif
                if autoscroll {
                    textView.scrollRangeToVisible(nsrange)
                }
            }
        }
        textView.isEditable   = flags.contains(.editable)
        textView.isSelectable = flags.contains(.selectable)
    }
    private var edgeInsets: UIEdgeInsets {
        return UIEdgeInsets(
            top    : inset.height, left  : inset.width,
            bottom : inset.height, right : inset.width
        )
    }
    public func makeUIView(context: Context) -> UITextView {
        let textView = UXCodeTextView()
        textView.autoresizingMask   = [ .flexibleWidth, .flexibleHeight ]
        textView.delegate           = context.coordinator
        textView.textContainerInset = edgeInsets
        textView.autocapitalizationType = .none
        textView.smartDashesType = .no
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.smartQuotesType = .no
        updateTextView(textView)
        return textView
    }
    public func updateUIView(_ textView: UITextView, context: Context) {
        guard let textView = textView as? UXCodeTextView else {
            assertionFailure("unexpected text view")
            return
        }
        if textView.delegate !== context.coordinator {
            textView.delegate = context.coordinator
        }
        textView.textContainerInset = edgeInsets
        updateTextView(textView)
    }
}

extension UXCodeTextViewRepresentable {
    // A wrapper around a `Bool` that enables updating
    // the wrapped value during `View` renders.
    private class ReferenceTypeBool {
        var value: Bool
        init(value: Bool) {
            self.value = value
        }
    }
}

struct UXCodeTextViewRepresentable_Previews: PreviewProvider {
    static var previews: some View{
        UXCodeTextViewRepresentable(source      : .constant("let a = 5"),
                                    selection   : nil,
                                    language    : nil,
                                    theme       : .xt256,
                                    fontSize    : nil,
                                    flags       : [ .selectable ],
                                    indentStyle : .system,
                                    autoPairs   : [:],
                                    inset       : .init(width: 8, height: 8),
                                    autoscroll  : false)
        .frame(width: 200, height: 100)
        UXCodeTextViewRepresentable(source: .constant("let a = 5"),
                                    selection   : nil,
                                    language    : .cpp,
                                    theme       : .xt256,
                                    fontSize    : nil,
                                    flags       : [ .selectable ],
                                    indentStyle : .system,
                                    autoPairs   : [:],
                                    inset       : .init(width: 8, height: 8),
                                    autoscroll  : false)
        .frame(width: 200, height: 100)
    }
}
