//
//  TypedString.swift
//  iMessagePlusPlus
//
//  Created by Morgan Marino on 4/3/23.
//

import Foundation
import SwiftUI

//makes typed strings
public protocol TypedString: RawRepresentable, Hashable, Comparable, Codable, CustomStringConvertible, Identifiable{
    var rawValue: String { get }
}

public extension TypedString where RawValue == String {
    
    @inlinable var description : String { return self.rawValue }
    @inlinable var id          : String { return self.rawValue }
    @inlinable static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}