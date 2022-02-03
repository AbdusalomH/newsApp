//
//  ImageCache.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 1/17/22.
//

import UIKit


class ImageCache {
    
    // MARK:- Get local URL to FileManager/Document for saving item
    func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: .userDomainMask).first else { return nil }
 
        
        return documentURL.appendingPathComponent(key).appendingPathExtension("jpg")
    }
    
  
    // MARK:- Save to local storage - Documents Directory
    func store(image: UIImage, key: String) {

        guard let pngRepresentation = image.jpegData(compressionQuality: 1) else {return}
        
        collectImages(imageName: key)

        if let filePath = filePath(forKey: key) {
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


        guard let imageExist = filePath(forKey: key) else {return nil}
        
        
        do {
            let imageData = try Data(contentsOf: imageExist)

            return UIImage(data: imageData, scale: UIScreen.main.scale)

        } catch {
            //print("No photo on local Directrory")
        }
        return nil
    }
    
    // MARK:- Save to cache folder of local Directory
    func cacheSaving(imageUrl:UIImage, imageTitle: String) {

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
    // MARK:- Get local image from local Cache folder of local Directory
    func getCachedImages(imageTitle: String) -> UIImage? {
        
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        
        if let imageTitles = cacheDirectory?.appendingPathComponent(imageTitle).appendingPathExtension("jpg") {
            do {
                
                let imageData = try Data(contentsOf: imageTitles)
                //print("Successfully added from Cache directory")
                
                return UIImage(data: imageData, scale: UIScreen.main.scale)
            }
            catch {
                print(error)
            }
        }
        return nil
    }
    
    func otherLocalStorage(image: UIImage, imageTitle: String) {
        
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
    
    func otherLocalStorage2(image: UIImage, imageTitle: String) {
        
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
    
    
    var imageArray: [String] = []
    
    
    func collectImages(imageName: String) {
        
        if !imageName.isEmpty {
                self.imageArray.append(imageName)
                print("zdes nash array \(self.imageArray.count)")
        }
    }
    
    
    func deleteItems(imageName: String) {
        

        let manager = FileManager.default
        
        if !imageName.isEmpty {
            
            if imageArray.count >= 4 {
                
                for _ in 1...5 {
                    
                    guard let shouldbeDeleted = imageArray.last, let removingPathUrl = filePath(forKey: shouldbeDeleted) else {return}
                    
                    print("Prishli syuda pered udaleniem")
                    imageArray.removeLast()
                    do {
                        //try manager.removeItem(atPath: removingPathUrl.absoluteString)
                        try manager.removeItem(at: removingPathUrl)
                        print("Smog udalit posledinie 5")
                    } catch {
                        print("nepoluchilos edalit")
                    }
                }
            }
        }
    }
}




