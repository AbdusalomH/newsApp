//
//  PoliticsVC.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 12/30/21.
//

import UIKit

class PoliticsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemRed
        
        let manager = FileManager.default
        
        guard let url = manager.urls(for: .documentDirectory, in: .localDomainMask).first else {
            return
        }
        
        print(url.path)
        
        
    }
}
