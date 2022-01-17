//
//  ImageCache.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 1/17/22.
//

import UIKit

class ImageCache {
    
    func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: .userDomainMask).first else { return nil }

        return documentURL.appendingPathComponent(key).appendingPathExtension("jpg")
    }

    func store(image: UIImage, key: String) {

        guard let pngRepresentation = image.jpegData(compressionQuality: 1) else {return}

        if let filePath = filePath(forKey: key) {
            do  {
                try pngRepresentation.write(to: filePath, options: .atomic)
                print("Successfully saved")
                
            } catch let err {
                print("Saving file resulted in error: ", err)
                print(err.localizedDescription)
            }
        }
    }

    func getLocalImage(key: String) -> UIImage? {

        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let imageExist = directory.appendingPathComponent(key).appendingPathExtension("jpg")
        

        do {
            let imageData = try Data(contentsOf: imageExist)

            return UIImage(data: imageData, scale: UIScreen.main.scale)

        } catch {
            print("No photo on local Directrory. \(error)")
        }
        return nil
    }
 
}
