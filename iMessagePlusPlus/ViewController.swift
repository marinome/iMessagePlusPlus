//
//  ViewController.swift
//  iMessagePlusPlus
//
//  Created by MM, edited by MM
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Courier New-Bold", size: 30)!]
        let lattributes = [NSAttributedString.Key.font: UIFont(name: "Courier New-Bold", size: 24)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().largeTitleTextAttributes = lattributes
        UINavigationBar.appearance().backgroundColor = UIColor(named: "LightGray")
    }
}

