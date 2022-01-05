//
//  MenuCell.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 12/23/21.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    static let reuseID = "NewsCell"

    
    let names = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func configure() {
        
        addSubview(names)
        
        names.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            names.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            names.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            names.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5),
            names.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5)

        ])
    }
}
