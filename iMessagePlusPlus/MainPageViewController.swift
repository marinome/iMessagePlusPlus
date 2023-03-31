//
//  MainPageViewController.swift
//  iMessagePlusPlus
//
//  Created by Morgan Marino on 3/30/23.
//

import UIKit

class MainPageViewController: UIViewController {
    
    @IBOutlet var codeField: UITextView!
    
    public var completion: ((String, String)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codeField.becomeFirstResponder()
        //BEGINNING OF ANJALI KEYBOARD CODE -MM
        view.addSubview(codeField)
        // Do any additional setup after loading the view.
        let toolBar = UIToolbar(frame: CGRect(x:0, y:0, width: view.frame.size.width, height: 50))
        //items
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target:self, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        codeField.inputAccessoryView = toolBar
        //END OF ANJALI KEYBOARD CODE -MM
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        codeField.frame = CGRect(x: 20,
                             y: 30 + view.safeAreaInsets.top,
                             width: view.frame.size.width-40, height: 50)
    }
    
    @objc func didTapDone(){ //repetitive, morgan is merging this with other one from AR -MM
        codeField.resignFirstResponder() //-AR
    }
    
    

/*@IBAction func moveCursorButtonPressed(_ sender: Any) {
 let newPosition = textField.selectedTextRange?.end.advanced(by: 4)
 textField.selectedTextRange = textField.textRange(from: newPosition!, to: newPosition!)
 }*/ //AUTO-INDENTATION FUNCTION WHEN UR READY-MM
// This will move the cursor positon 4 places the orginial allocation


}
