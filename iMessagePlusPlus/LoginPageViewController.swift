//
//  LoginPageViewController.swift
//  iMessagePlusPlus
//
//  Created by Morgan Marino on 3/30/23.
//

import UIKit

class LoginPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iMessage++"
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapGetStarted(){
        guard let vc = storyboard?.instantiateViewController(identifier: "mainpage") as? MainPageViewController else{
            return
        }
        vc.title = "Main Page"
        navigationController?.pushViewController(vc, animated: true)
    }
}