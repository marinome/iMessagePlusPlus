//
//  ContentView.swift
//  iMessage
//
//  Created by MM & DS
//

import SwiftUI

struct ContentView: View {
    let m_font = Font
        .system(size: 24)
        .monospaced()
    let m_white = Color(red: 246/255, green: 246/255, blue: 246/255)
    let m_black = Color(red: 30/255, green: 30/255, blue: 31/255)
    let m_lightgray = Color(red: 202/255, green: 204/255, blue: 210/255)
    let m_rose = Color(red: 234/255, green: 66/255, blue: 143/255)
    let m_red = Color(red: 233/255, green: 64/255, blue: 47/255)
    let m_yellow = Color(red: 223/255, green: 253/255, blue: 82/255)
    let m_lizardgreen = Color(red: 174/255, green: 250/255, blue: 78/255)
    let m_springgreen = Color(red: 116/255, green: 251/255, blue: 175/255)
    let m_blue = Color(red: 102/255, green: 221/255, blue: 239/255)
    @State private var code: String = ""
    @State private var language: String = ""
    var body: some View {
        //WelcomeScreenView()
        VStack(alignment: .leading){
            Text("//iMessage++\n-Group 15")
                .font(m_font)
                .foregroundColor(m_lightgray)
            Text("Test - White")
                .font(m_font)
                .foregroundColor(m_white)
            Text("Test - Black")
                .font(m_font)
                .foregroundColor(m_black)
            Text("Test - Rose")
                .font(m_font)
                .foregroundColor(m_rose)
            Text("Test - Red")
                .font(m_font)
                .foregroundColor(m_red)
            Text("Test - Yellow")
                .font(m_font)
                .foregroundColor(m_yellow)
            Text("Test - Lizard Green")
                .font(m_font)
                .foregroundColor(m_lizardgreen)
            Text("Test - Spring Green")
                .font(m_font)
                .foregroundColor(m_springgreen)
            Text("Test - Blue")
                .font(m_font)
                .foregroundColor(m_blue)
            TextField("Code Here: ",text: $code)
                .font(m_font)
                .foregroundColor(m_black)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*struct PrimaryButton: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor"))
            .cornerRadius(50)
    }
}*/

/*extension ContentView {
    //generates theme w/ colors, parameter is theme (default for now), returns theme colors
    static public func getTheme(name: String) -> Theme? {
        if let theme = themes[name] {
            let defaultColor = ThemeColor(hex: (theme["default"] as? String) ?? "theme_black")
            let backgroundColor = ThemeColor(hex: (theme["background"] as? String) ?? "theme_white")
            let currentLineColor = ThemeColor(hex: (theme["currentLine"] as? String) ?? "theme_rose")
            let selectionColor = ThemeColor(hex: (theme["selection"] as? String) ?? "theme_yellow")
            //let cursorColor = ThemeColor(hex: (theme["cursor"] as? String) ?? "#000000")
            let styleRaw = theme["style"] as? String
            let style: Theme.UIStyle = styleRaw == "light" ? .light : .dark
            //let lineNumber = ThemeColor(hex: (theme["lineNumber"] as? String) ?? "#000000")
            //let lineNumber_Active = ThemeColor(hex: (theme["lineNumber-Active"] as? String) ?? "#000000")
            var colors: [String: ThemeColor] = [:]
            if let cDefs = theme["definitions"] as? [String: String] {
                for item in cDefs {
                    colors.merge([item.key: ThemeColor(hex: (item.value))]) { (first, _) -> ThemeColor in return first }
                }
            }
            return Theme(defaultFontColor: defaultColor, backgroundColor: backgroundColor, currentLine: currentLineColor, selection: selectionColor, colors: colors, font: ThemeFont.systemFont(ofSize: ThemeFont.systemFontSize), style: style)
        }
        return nil
    }
}*/
