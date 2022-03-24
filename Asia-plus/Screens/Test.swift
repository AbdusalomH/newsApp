//
//  Test.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 1/29/22.
//

import UIKit

class Test: UIViewController {
    
    let yellowView = UIView()
    let redView = UIView()
        
    
    var regularConstraints1 = [NSLayoutConstraint]()
    var compactConstraints1 = [NSLayoutConstraint]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //configureViews()
        view.backgroundColor = .systemBackground
        addToViews()
        enableConstraintsForWidth(horizontalSizeClass: traitCollection.horizontalSizeClass)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    

    func addToViews() {
        
        view.addSubview(yellowView)
        view.addSubview(redView)
        
        yellowView.backgroundColor = .yellow
        redView.backgroundColor = .red
        
        yellowView.translatesAutoresizingMaskIntoConstraints = false
        redView.translatesAutoresizingMaskIntoConstraints = false
        
        
 
    }


    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass {
            enableConstraintsForWidth(horizontalSizeClass: traitCollection.horizontalSizeClass)
        }
    }
    
    
    func compactConstraints() -> [NSLayoutConstraint] {
 
        self.compactConstraints1.append(yellowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10))
        self.compactConstraints1.append(yellowView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        self.compactConstraints1.append(yellowView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        self.compactConstraints1.append(yellowView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4))
        
        
        self.compactConstraints1.append(redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10))
        self.compactConstraints1.append(redView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10))
        self.compactConstraints1.append(redView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        self.compactConstraints1.append(redView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40))
        
        return compactConstraints1
        
        }
    
    
    func regularContraints () -> [NSLayoutConstraint] {
        
        self.regularConstraints1.append(yellowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10))
        self.regularConstraints1.append(yellowView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        self.regularConstraints1.append(yellowView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10))
        self.regularConstraints1.append(yellowView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5, constant: -30))
        
        
        self.regularConstraints1.append(redView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        self.regularConstraints1.append(redView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10))
        self.regularConstraints1.append(redView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        //self.regularConstraints1.append(redView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5, constant: -30))
        self.regularConstraints1.append(redView.topAnchor.constraint(equalTo: yellowView.bottomAnchor, constant: 20))
        

        return regularConstraints1
        
    }
    
    
    func enableConstraintsForWidth(horizontalSizeClass: UIUserInterfaceSizeClass) {
        
        if horizontalSizeClass == .compact {
            
            print("Portrait mode")
            
            NSLayoutConstraint.deactivate(regularContraints())
            NSLayoutConstraint.activate(compactConstraints())
            
        } else {
            print("Landscape mode")
            NSLayoutConstraint.deactivate(compactConstraints())
            NSLayoutConstraint.activate(regularContraints())
            
        }
    
    }
    
    
//    override func viewDidLayoutSubviews() {
//        enableConstraintsForWidth(horizontalSizeClass: traitCollection.horizontalSizeClass)
//    }
    
}

