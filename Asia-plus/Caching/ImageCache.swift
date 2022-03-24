//
//  ImageCache.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 1/17/22.
//

import UIKit


class ImageCache {
    
    static var cacheLimit = CacheLimitSize()
    
    // MARK:- Get local URL to FileManager/Document for saving item
    static func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: .userDomainMask).first else { return nil }
        
        print(documentURL)
 
        return documentURL.appendingPathComponent(key).appendingPathExtension("jpg")
    }
    
  
    // MARK:- Save to local storage - Documents Directory
    func store(image: UIImage, key: String) {

        guard let pngRepresentation = image.jpegData(compressionQuality: 1) else {return}
        
        Self.cacheLimit.collectImages(imageName: key)
        Self.cacheLimit.deleteItems(imageName: key)

        if let filePath = ImageCache.filePath(forKey: key) {
            do  {
                try pngRepresentation.write(to: filePath, options: .atomic)
                //print("Successfully saved")
                //print(filePath)
                
            } catch let err {
                //print("Saving file resulted in error: ", err)
                print(err.localizedDescription)
            }
        }
    }
    // MARK:- Get local image from Documents directory
    func getLocalImage(ket key: String) -> UIImage? {

        guard let imageExist = ImageCache.filePath(forKey: key) else {return nil}
        
        
        do {
            let imageData = try Data(contentsOf: imageExist)

            return UIImage(data: imageData, scale: UIScreen.main.scale)

        } catch {
            //print("No photo on local Directrory")
        }
        return nil
    }
    
}




