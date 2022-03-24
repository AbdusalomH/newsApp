//
//   FlowlayutClass.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 1/17/22.
//

import UIKit

class FlowlayutClass {
    
    static func flowLayoutConfigure(in view: UIView) -> UICollectionViewLayout {
        
        let width                   = view.bounds.width
        let usedPadding: CGFloat    = 10
        let availableSpace: CGFloat = width - usedPadding
        
        let flowLayout              = UICollectionViewFlowLayout()
        flowLayout.sectionInset     = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.itemSize         = CGSize(width: availableSpace, height: 250)
        
        return flowLayout
    }
}
