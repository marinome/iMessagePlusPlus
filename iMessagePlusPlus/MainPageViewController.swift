//
//  MainPageViewController.swift
//  iMessagePlusPlus
//
//  Created by MM, edited by MM
//

import UIKit
import SwiftUI
import CodeEditor

class MainPageViewController: UIViewController, UITextViewDelegate {
    
    let contentView = UIHostingController(rootView: ContentView())
    
    @IBOutlet var codeField: UITextView!
    
    public var completion: ((String, String)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        codeField.inputAccessoryView = toolBar
    //END OF KEYBOARD CODE -MM
    }
    
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
    
    private func setupConstraints(){
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: codeField.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: codeField.bottomAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo: codeField.leftAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: codeField.rightAnchor).isActive = true
    }
}
