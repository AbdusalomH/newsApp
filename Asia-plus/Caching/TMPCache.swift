//
//  TMPCache.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 2/16/22.
//

import UIKit

class TMPCache {
    
    static func otherLocalStorage2(image: UIImage, imageTitle: String) {
        
        let getDirectory = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        
        
        guard let downloadedImage = image.jpegData(compressionQuality: 1) else {return}
        
        let imageDirectory = getDirectory.appendingPathComponent(imageTitle).appendingPathExtension("jpg")
        
       
        do {
            try downloadedImage.write(to: imageDirectory)
            print("soxtanit")
            //print(imageDirectory)
            
        } catch {
                
            print(error)
            print("maza neyu")
                
        }
    }
    
    
    
}
