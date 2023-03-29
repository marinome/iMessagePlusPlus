//
//  Theme_Def.swift
//  iMessage
//
//  Created by MM
//

#if canImport(UIKit)
import UIKit
#endif

//swift's version of a header file, where types of each variable is defined for the theme
public struct Theme {
    public enum UIStyle {
        case dark
        case light
    }
    
    public var defaultFontColor: ThemeColor
    public var backgroundColor: ThemeColor
    public var currentLine: ThemeColor
    public var selection: ThemeColor
    public var colors: [String: ThemeColor]
    public var font: ThemeFont
    public var style: UIStyle
}
