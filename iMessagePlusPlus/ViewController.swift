//
//  ViewController.swift
//  iMessagePlusPlus
//
//  Created by MM, edited by MM
//

import UIKit

class ViewController: UIViewController {
    // Override the viewDidLoad() method from the superclass to perform additional setup after the view has been loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        // Define the attributes for the title and large title text of the navigation bar
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Courier New-Bold", size: 30)!]
        let lattributes = [NSAttributedString.Key.font: UIFont(name: "Courier New-Bold", size: 24)!]
        // Set the appearance of the navigation bar to match the defined attributes
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().largeTitleTextAttributes = lattributes
         // Set the background color of the navigation bar to a predefined color
        UINavigationBar.appearance().backgroundColor = UIColor(named: "LightGray")
    }
}

