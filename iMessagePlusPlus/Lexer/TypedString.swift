//
//  TypedString.swift
//  iMessagePlusPlus
//
//  Created by MM, edited by MM
//

import Foundation
import SwiftUI

//makes typed strings
public protocol TypedString: RawRepresentable, Hashable, Comparable, Codable, CustomStringConvertible, Identifiable{
    var rawValue: String { get }
}

public extension TypedString where RawValue == String {
    // Returns the string representation of the typed string
    @inlinable var description : String { return self.rawValue }
    // Returns the identifier of the typed string
    @inlinable var id          : String { return self.rawValue }
    // Comparison operator for typed strings
    @inlinable static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
