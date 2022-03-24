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
    
    static let imageCache = ImageCache()
    
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
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        configure()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        
        addSubview(newsAvatar)
        addSubview(newsText)
        
        newsAvatar.translatesAutoresizingMaskIntoConstraints = false
        newsText.translatesAutoresizingMaskIntoConstraints = false
        
        newsText.numberOfLines = 3
        newsText.adjustsFontSizeToFitWidth = true
        
        newsAvatar.layer.cornerRadius = 5
        newsAvatar.clipsToBounds = true
        newsAvatar.contentMode = .scaleAspectFit
        setNeedsDisplay()
        newsAvatar.layer.needsDisplayOnBoundsChange = true
        
        
 
        newsAvatar.image = UIImage(named: placeholder)
            
        NSLayoutConstraint.activate([
            
//            newsAvatar.topAnchor.constraint(equalTo: contentView.topAnchor),
//            newsAvatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            newsAvatar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            newsAvatar.heightAnchor.constraint(equalToConstant: 220),
            
//            newsAvatar.widthAnchor.constraint(equalTo: newsAvatar.widthAnchor, multiplier: 0.5),
//            newsAvatar.heightAnchor.constraint(equalToConstant: 50),
//            newsAvatar.widthAnchor.constraint(equalToConstant: 50),
            
            newsAvatar.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            newsAvatar.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            newsAvatar.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            newsAvatar.heightAnchor.constraint(equalTo: newsAvatar.widthAnchor, multiplier: 0.54),
            
            newsText.topAnchor.constraint(equalTo: newsAvatar.bottomAnchor, constant: 10),
            newsText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            newsText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func downloadImage(data: String?, title: String) {
      
        guard let image2 = data else {return}
        let cacheKey = NSString(string: image2)
    
        if let image1 = NewsCell.cache.object(forKey: cacheKey) {
    
            self.newsAvatar.image = image1
            return
                
        } else {
    
            self.newsAvatar.image = UIImage(named: placeholder)
        }
        
        if let image = NewsCell.imageCache.getLocalImage(ket: title) {

            newsAvatar.image = image
            print("Successfully added")
            return

        } else {

            newsAvatar.image = UIImage(named: placeholder)
        }
        
        
        if let image = ImageCacheLibrary.getCachedImages(imageTitle: title) {
            
            DispatchQueue.main.async {
                self.newsAvatar.image = image
            }
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

                            
            DispatchQueue.main.async {
                self.newsAvatar.image = image
                Self.imageCache.store(image: image, key: title)
                                    
            }
        }
        task.resume()
        self.newValue = task
    }
}



    
 






