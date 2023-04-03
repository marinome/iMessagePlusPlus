//
//  ContentView.swift
//  iMessagePlusPlus
//
//  Created by Morgan Marino on 4/2/23.
//

import SwiftUI
import CodeEditor
import Highlightr
//import Lexer
/*public extension Lexer.ThemeName{
    static var imessageplusplus = Lexer.ThemeName(rawValue:"imessageplusplus")
}*/
public extension Lexer.ThemeName{
    static var xt256 = Lexer.ThemeName(rawValue:"xt256")
}

struct ContentView: View {
    static private let initialSource = "//Type code here...\n"
    @State private var source = Self.initialSource
    @State private var selection = Self.initialSource.endIndex..<Self.initialSource.endIndex
    
    var body: some View {
        Lexer(source: $source, selection: $selection, language: .cpp, theme: .xt256,  flags: [ .selectable, .editable, .smartIndent], indentStyle: .softTab(width: 4), autoPairs: [ "{": "\n}", "'": "'"/*, "(": ")"*/ ])
        Button("Select All") {
            selection = source.startIndex..<source.endIndex
        }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    //https://developer.apple.com/documentation/swiftui/view/toolbar(content:)-5w0tj
                }
            }
    }
}
/*TextEditor(text: $text)
 
 .toolbar {
 ToolbarItemGroup(placement: .keyboard) {
 Button("Reset"){
 self.tapDone = "Done"
 }
 }
 } */

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 
 @State private var source = Self.initialSource
 @State private var selection = Self.initialSource.endIndex..<Self.initialSource.endIndex

     Button("Select All") {
         selection = source.startIndex..<source.endIndex
     }*/
