//
//  MainPageViewController.swift
//  iMessagePlusPlus
//
//  Created by MM, edited by MM
//

import UIKit
import SwiftUI
import CodeEditor
import Highlightr
//import Lexer

class MainPageViewController: UIViewController, UITextViewDelegate {
    //Start Lexer
    //buttons for functionality 
    //@IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    //@IBOutlet weak var viewPlaceholder: UIView!
    var textView : UITextView!
    @IBOutlet var textToolbar: UIToolbar!
    @IBOutlet weak var languageName: UILabel!
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var highlightr : Highlightr!
    let textStorage = CodeAttributedString()
    //end Lexer
    let contentView = UIHostingController(rootView: ContentView())
    
    //create button
    @IBOutlet var codeField: UITextView!
    
    public var completion: ((String, String)->Void)?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //navigationController?.pushViewController(contentView, animated: false)
        //start Lexer
        //activityIndicator.isHidden = true
        //languageName.text = "CPP"
        
        textStorage.language = "cpp".lowercased()
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: view.bounds.size)
        layoutManager.addTextContainer(textContainer)
        
        //auto correct typing into correct syntax of programming language 
        textView = UITextView(frame: CGRect(x: 20, y: 30 + view.safeAreaInsets.top, width: view.frame.size.width-40, height: 50), textContainer: textContainer)
        textView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textView.autocorrectionType = UITextAutocorrectionType.no
        textView.autocapitalizationType = UITextAutocapitalizationType.none
        textView.textColor = UIColor(named: "LizardGreen")
        textView.inputAccessoryView = textToolbar
        //viewPlaceholder.addSubview(textView)
        
        
        let code = "int main(){\n\treturn 0;\n}"
        textView.text = code
        highlightr = textStorage.highlightr
        textView.backgroundColor = UIColor(named: "Black")
        //languageName.textColor = UIColor(named: "Blue")
        //end Lexer
        
        codeField.becomeFirstResponder()
        codeField.font = UIFont(name: "Courier New", size: 14)
        view.addSubview(codeField)
        addChild(contentView)
        view.addSubview(contentView.view)
        setupConstraints()
        
        //KEYBOARD CODE -MM
        // Do any additional setup after loading the view.
        let toolBar = UIToolbar(frame: CGRect(x:0, y:0, width: view.frame.size.width, height: 50))
        //toolBar items
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target:self, action: nil)
        let tabButton = UIBarButtonItem(title: "Tab", style: .plain, target: self, action: #selector(didTapTab))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        toolBar.items = [tabButton, flexibleSpace, doneButton]
        toolBar.sizeToFit()
        codeField.inputAccessoryView = toolBar //create the pop up keyboard functionality 
        //END OF KEYBOARD CODE -MM
    }
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        codeField.frame = CGRect(x: 20, y: 30 + view.safeAreaInsets.top, width: view.frame.size.width-40, height: 50) //not sure what this does
    }
    
    @objc func didTapDone(){ //repetitive, merged with other one from AR -MM
        codeField.resignFirstResponder() //-AR
    }
    
    @objc func didTapTab(_ sender: Any){ //AUTO-INDENTATION FUNCTION WHEN UR READY-MM
        codeField.text += "    "
    }
    //set up how the code will display to the user
    private func setupConstraints(){
     contentView.view.translatesAutoresizingMaskIntoConstraints = false
     contentView.view.topAnchor.constraint(equalTo: codeField.topAnchor).isActive = true
     contentView.view.bottomAnchor.constraint(equalTo: codeField.bottomAnchor).isActive = true
     contentView.view.leftAnchor.constraint(equalTo: codeField.leftAnchor).isActive = true
     contentView.view.rightAnchor.constraint(equalTo: codeField.rightAnchor).isActive = true
     }
    //follows the syntax of C++
    @IBAction func pickLanguage(_ sender: AnyObject){
        let snippetPath = Bundle.main.path(forResource: "default", ofType: "txt", inDirectory: "Samples/cpp", forLocalization: nil)
        let snippet = try! String(contentsOfFile: snippetPath!)
        self.textView.text = snippet
        //cancel: nil,
        //origin: toolBar)
    }
    //closes keyboard on main page
    @IBAction func hideKeyboard(_ sender: AnyObject?){
        textView.resignFirstResponder()
    }
//Start of DS code
/*if let highlightr = highlightr {
    let range = NSRange(location: 0, length: textView.text.count)
    let color = highlightr.color(for: textView.text, as: textStorage.language ?? "")
    textView.tintColor = color
}

function that should change cursor
func textViewDidChange(_ textView: UITextView) {
    if let highlightr = highlightr {
        let range = NSRange(location: 0, length: textView.text.count)
        let color = highlightr.color(for: textView.text, as: textStorage.language ?? "")
        textView.tintColor = color
    }
}*/ //DS - should fix cursor and "Select All" color

}

/*func createTextView() {
    let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
    let attrString = NSAttributedString(string: note.contents, attributes: attrs)
    textStorage = SyntaxHighlightTextStorage()
    textStorage.append(attrString)
    let newTextViewRect = view.bounds
    let layoutManager = NSLayoutManager()
    let containerSize = CGSize(width: newTextViewRect.width, height: .greatestFiniteMagnitude)
    let container = NSTextContainer(size: containerSize)
    container.widthTracksTextView = true
    layoutManager.addTextContainer(container)
    textStorage.addLayoutManager(layoutManager)
    textView = UITextView(frame: newTextViewRect, textContainer: container)
    textView.delegate = self
    view.addSubview(textView)
    textView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        textView.topAnchor.constraint(equalTo: view.topAnchor),
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
}*/
