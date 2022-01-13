//
//  NewsCell.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 12/17/21.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    
    static let reuseID = "NewsCell"
    
    static var cache = NSCache<NSString, UIImage>()
    
    var newValue: URLSessionDataTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newValue?.cancel()

    }
    
    var newsAvatar = UIImageView()
    var newsText = UILabel()
    
    let placeholder = "bbc"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func configure() {
        
        addSubview(newsAvatar)
        addSubview(newsText)
        
        newsAvatar.translatesAutoresizingMaskIntoConstraints = false
        newsText.translatesAutoresizingMaskIntoConstraints = false
        
        
        let padding: CGFloat = 10
        
        newsText.numberOfLines = 3
        newsText.adjustsFontSizeToFitWidth = true
        newsAvatar.contentMode = .scaleToFill
        newsAvatar.layer.cornerRadius = 5
        newsAvatar.layer.needsDisplayOnBoundsChange = true
        newsAvatar.layer.masksToBounds = true

  
        newsAvatar.image = UIImage(named: placeholder)
        

        NSLayoutConstraint.activate([
        
            newsAvatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            newsAvatar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            newsAvatar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            newsAvatar.heightAnchor.constraint(equalTo: newsAvatar.widthAnchor, multiplier: 0.56),
            
            newsText.topAnchor.constraint(equalTo: newsAvatar.bottomAnchor, constant: 10),
            newsText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            newsText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            newsText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        
        ])
    }
    
    
    func downloadImage(data: String?) {
                                
        guard let image2 = data else {return}
        print()
       
        let cacheKey = NSString(string: image2)
        
        if let image1 = NewsCell.cache.object(forKey: cacheKey) {
           
            self.newsAvatar.image = image1
            return
            
        } else {
            
            self.newsAvatar.image = UIImage(named: placeholder)
        
        }

        
        guard let baseUrl = data else {return}
        
        guard let endpoint = URL(string: baseUrl) else {return}
        
        let task = URLSession.shared.dataTask(with: endpoint) { [weak self] data, response, error in
            
            guard let self = self else { return }

            if error != nil  {return}
            
            guard let data = data else {return}
            guard let image = UIImage(data: data) else {return}
            
            NewsCell.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.global(qos: .background).async {
               
                self.store(image: image, key: image2)
                
                DispatchQueue.main.async {
            
                    self.newsAvatar.image = image
                
                }
            }
        }
        
        task.resume()
        self.newValue = task
    }
    
    func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }

        return documentURL.appendingPathComponent(key)
    }
    
    func store(image: UIImage, key: String) {
        
        guard let pngRepresentation = image.jpegData(compressionQuality: 1) else {return}

        if let filePath = filePath(forKey: key) {
            do  {
                try pngRepresentation.write(to: filePath, options: .atomic)
            } catch let err {
                print("Saving file resulted in error: ", err)
            }
        }
    }
    
    func getLocalImage(key: String) -> UIImage? {
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let imageExist = directory.appendingPathComponent(key)
        
        do {
            let imageData = try Data(contentsOf: imageExist)
            
            return UIImage(data: imageData)
            
        } catch {
            print(error)
        }
        return nil
    }
}



    
 






