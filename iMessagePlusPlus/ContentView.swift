//
//  ContentView.swift
//  iMessagePlusPlus
//
//  Created by Morgan Marino on 4/2/23.
//

import SwiftUI
import CodeEditor

struct ContentView: View {
    @State private var source = "//Type code here..."
    
    var body: some View {
        CodeEditor(source: $source, language: .cpp, theme: .ocean,  flags: [ .selectable, .editable, .smartIndent], autoPairs: [ "{": "}", "'": "'" ])
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
