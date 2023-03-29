//
//  RGBtoHex.swift
//  iMessage
//
//  Created by MM
//

#if canImport(UIKit)
import UIKit
#endif

extension ThemeColor {
    
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        let a: CGFloat = 1.0 //alpha, don't think we need it, but we'll see

       //let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else{self.init(red: r, green: g, blue: b, alpha: a);return}
        r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        b = CGFloat(rgb & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
