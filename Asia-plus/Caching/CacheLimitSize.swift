//
//  CacheLimitSize.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 2/16/22.
//

import Foundation


class CacheLimitSize {
    
    private var imageArray: [String] = []
    
    
    func collectImages(imageName: String) {
        
        if !imageName.isEmpty {
                print("zdes nash array \(self.imageArray.count)")
                print(imageArray)
                self.imageArray.append(imageName)
                print(" updated zdes nash array \(self.imageArray.count)")
                print(imageArray)
        }
    }
    
    
    func deleteItems(imageName: String) {
        

        let manager = FileManager.default
        
        if !imageName.isEmpty {
            
            if imageArray.count >= 25 {
                
                for _ in 1...15 {
                    
                    guard let shouldbeDeleted = imageArray.last, let removingPathUrl = ImageCache.filePath(forKey: shouldbeDeleted) else {return}
                    
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
