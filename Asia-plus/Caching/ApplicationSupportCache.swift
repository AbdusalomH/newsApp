//
//  ApplicationSupportCache.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 2/16/22.
//

import UIKit


class ApplicationSupporCache {
    
    static func otherLocalStorage(image: UIImage, imageTitle: String) {
        
        let getDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
        
        
        guard let downloadedImage = image.jpegData(compressionQuality: 1) else {return}
        
        let imageDirectory = getDirectory?.appendingPathComponent(imageTitle).appendingPathExtension("jpg")
        
        if let imageExist = imageDirectory {
            do {
                try downloadedImage.write(to: imageExist)
                
                
            } catch {
                
                print(error)
                
            }
            
        }
        
    }
}
