//
//  DownloadImage.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 1/18/22.
//

import UIKit

class ImageManipulation {
    
    
    func loadImage(imageUrl: String) -> Data? {
        
        if let imgUrl = URL(string: imageUrl) {
            
            do {

                let imageData = try Data(contentsOf: imgUrl)
                                
                return imageData

            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}


