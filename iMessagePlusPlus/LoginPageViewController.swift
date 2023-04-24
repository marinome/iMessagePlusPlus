//
//  LoginPageViewController.swift
//  iMessagePlusPlus
//
//  Created by MM
//

import UIKit

class LoginPageViewController: UIViewController {
    // Called after the view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the title of the navigation bar
        title = "iMessage++"
        // Do any additional setup after loading the view.
        
    }
    // Called when the "Get Started" button is tapped
    @IBAction func didTapGetStarted(){
        // Try to get the main page view controller from the storyboard
        guard let vc = storyboard?.instantiateViewController(identifier: "mainpage") as? MainPageViewController else{
            return
        }
        // Set the title of the main page view controller
        vc.title = "Main Page"
        // Push the main page view controller onto the navigation stack
        navigationController?.pushViewController(vc, animated: true)
    }
}
