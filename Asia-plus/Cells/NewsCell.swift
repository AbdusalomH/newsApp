//
//  NewsCell.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 12/17/21.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    let imageCache = ImageCache()
    
    
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
    
    
    func downloadImage(data: String?, title: String) {
                                
//        guard let image2 = data else {return}
//
//        let cacheKey = NSString(string: image2)
//
//        if let image1 = NewsCell.cache.object(forKey: cacheKey) {
//
//            self.newsAvatar.image = image1
//            return
//        } else {
//
//            self.newsAvatar.image = UIImage(named: placeholder)
//        }
        
        if let image = imageCache.getLocalImage(key: title) {
            
            newsAvatar.image = image
            print("Successfully added")
            return
            
        } else {
            
            newsAvatar.image = UIImage(named: placeholder)
            
        }

        guard let baseUrl = data else {return}
        
        guard let endpoint = URL(string: baseUrl) else {return}
        
        let task = URLSession.shared.dataTask(with: endpoint) { [weak self] data, response, error in
            
            guard let self = self else { return }

            if error != nil  {return}
            
            guard let data = data else {return}
            guard let image = UIImage(data: data) else {return}
            
            //NewsCell.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.global(qos: .background).async {
                
                self.imageCache.store(image: image, key: title)
                               
                DispatchQueue.main.async {
            
                    self.newsAvatar.image = image
                
                }
            }
        }
        task.resume()
        self.newValue = task
    }
}



    
 






