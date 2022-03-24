//
//  ImageCacheLibrary.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 2/16/22.
//

import Foundation
import UIKit


class ImageCacheLibrary {
    
    
    // MARK:- Get local image from local Cache folder of local Directory
    
    static func getCachedImages(imageTitle: String) -> UIImage? {
        
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        
        if let imageTitles = cacheDirectory?.appendingPathComponent(imageTitle).appendingPathExtension("jpg") {
            do {
                
                let imageData = try Data(contentsOf: imageTitles)
                print(imageData)
                //print("Successfully added from Cache directory")
                
                return UIImage(data: imageData, scale: UIScreen.main.scale)
            }
            catch {
                print(error)
            }
        }
        return nil
    }
    
    
    // MARK:- Save to cache folder of local Directory
    
    static func cacheSaving(imageUrl:UIImage, imageTitle: String) {

        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first

        let imageDirectory = cacheDirectory?.appendingPathComponent(imageTitle).appendingPathExtension("jpg")
        
        guard let image = imageUrl.jpegData(compressionQuality: 1) else {return}
        
        if let imageExist = imageDirectory {
            do {
                try image.write(to: imageExist, options: .atomic)
                //print("Successfully saved to Cache directory")
            }
            catch{
                print(error)
            }
            
        }
    }
    
    
    
    
    
    
    
}
