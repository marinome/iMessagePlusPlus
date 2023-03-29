//
//  Languages_Def.swift
//  iMessage
//
//  Created by MM
//

import SwiftUI //needed?

#if canImport(UIKit)
import UIKit
#endif

struct Languages_Def { //Swift's version of a header file...types and formatting for all of the parts in Languages.Swift
    var type: String
    var regex: String
    var group: Int
    var relevance: Int
    var matches: [NSRegularExpression.Options] //regex-related stuff provided by swift
    var multiLine: Bool
}
