//
//  Test.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 1/29/22.
//

import UIKit

class Test: UIViewController {
    
    let leftView = UIView()
    let rightView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        view.backgroundColor = .systemBackground

    }
    
    func configureViews() {
        
        view.addSubview(leftView)
        view.addSubview(rightView)
        
        leftView.backgroundColor = .yellow
        rightView.backgroundColor = .red
        
        leftView.translatesAutoresizingMaskIntoConstraints = false
        rightView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            leftView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            leftView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            leftView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            leftView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.48),
            
            rightView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            rightView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            rightView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            rightView.widthAnchor.constraint(equalTo: leftView.widthAnchor),

        
        ])
        
    }
}
