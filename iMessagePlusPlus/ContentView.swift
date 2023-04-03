//
//  ContentView.swift
//  iMessagePlusPlus
//
//  Created by Morgan Marino on 4/2/23.
//

import SwiftUI
import CodeEditor
public extension CodeEditor.ThemeName{
    static var imessageplusplus = CodeEditor.ThemeName(rawValue:"imessage-plus-plus")
}

struct ContentView: View {
    @State private var source = "//Type code here..."
    
    var body: some View {
        CodeEditor(source: $source, language: .cpp, theme: .atelierSavannaDark,  flags: [ .selectable, .editable, .smartIndent], autoPairs: [ "{": "}", "'": "'", "(": ")" ])
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    //https://developer.apple.com/documentation/swiftui/view/toolbar(content:)-5w0tj
                }
               /*  var body: some View {
        TextEditor(text: $text)
           
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                Button("Reset"){
                self.tapDone = "Done"   
            }
            }
} */
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/* static private let initialSource = "let a = 42\n"
 
 @State private var source = Self.initialSource
 @State private var selection = Self.initialSource.endIndex..<Self.initialSource.endIndex

 var body: some View {
     CodeEditor(source: $source,
                selection: $selection,
                language: .swift,
                theme: .ocean,
                autoscroll: false)
     Button("Select All") {
         selection = source.startIndex..<source.endIndex
     }
 }*/
