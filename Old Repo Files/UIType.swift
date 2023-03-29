//
//  UIType.swift
//  iMessage
//
//  Created by MM
//

import SwiftUI

/*makes converting between AppKit and UIKit way easier; makes common typaliases for classes & types in either framework; includes a few of extensions that make using AppKit easier when coming from UIKit*/

#if canImport(UIKit)
import UIKit

//public typealias ContentView = UIView
public typealias ThemeColor = UIColor
public typealias ThemeFont = UIFont
public typealias ThemeImage = UIImage
public typealias TextView = UITextView
public typealias BezierPath = UIBezierPath
public typealias ThemeScrollView = UIScrollView
public typealias Screen = UIScreen
public typealias Window = UIWindow
public typealias EdgeInsets = UIEdgeInsets
public typealias TextViewDelegate = UITextViewDelegate

public typealias ViewRepresentable = UIViewRepresentable
public typealias KeyCommand = UIKeyCommand

#elseif canImport(AppKit)
import AppKit

//public typealias ThemeView = NSView
public typealias ThemeColor = NSColor
public typealias ThemeFont = NSFont
public typealias ThemeImage = NSImage
public typealias TextView = NSTextView
public typealias BezierPath = NSBezierPath
public typealias ThemeScrollView = NSScrollView
public typealias Screen = NSScreen
public typealias Window = NSWindow
public typealias EdgeInsets = NSEdgeInsets
public typealias TextViewDelegate = NSTextViewDelegate

public typealias ViewRepresentable = NSViewRepresentable
public typealias KeyCommand = NSLimitedKeyCommand

extension NSColor {
    static var label: NSColor {
        return NSColor.labelColor
    }
    
    static var systemBackground: NSColor {
        return NSColor.textBackgroundColor
    }
}

extension NSTextView {
    var text: String {
        get {
            return self.string
        }
        set {
            self.string = newValue
        }
    }
}

extension NSFont {
    //TODO: Implement This
    static func italicSystemFont(ofSize fontSize: CGFloat) -> NSFont {
        return NSFont.systemFont(ofSize: fontSize)
    }
}

#endif
