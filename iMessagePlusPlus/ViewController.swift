//
//  ViewController.swift
//  iMessagePlusPlus
//
//  Created by Morgan Marino on 3/28/23.
//

import UIKit

class ViewController: UIViewController {
    private let textVIew: UITextView = { //text view for input
        let view = UITextView()
        view.isEditable = true
        view.backgroundColor = .black
        //view.font = .system, FontofSize: 22, weight: .regular)
        return view
    }()
    private let highlight: UIButton = { //Highlight button
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .yellow
        button.setTitleColor(.black, for: .normal)
        button.setTitle("HIGHLIGHT",for: .normal)
        button.layer.cornerRadius = 22
        return button
    }()
    override func viewDidLoad(){
        super.viewDidLoad()
        //view.backgroundColor = .systemBackground
        view.addSubview(textVIew)
        view.addSubview(highlight)
        highlight.addTarget(
            self,
            action: #selector(didTapButton),
            for: .touchUpInside
        )
        addConstraints()
    }
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        textVIew.becomeFirstResponder()
    }
    @objc private func didTapButton(){
        textVIew.resignFirstResponder()
    }
    private func addConstraints(){
        NSLayoutConstraint.activate([
            textVIew.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            textVIew.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            textVIew.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textVIew.bottomAnchor.constraint(equalTo: highlight.topAnchor, constant: -10),
            highlight.widthAnchor.constraint(equalToConstant: 300),
            highlight.heightAnchor.constraint(equalToConstant: 50),
            highlight.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            highlight.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor,constant: -10),
        ])
    }
}

