//
//  SportNewsCell.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 1/8/22.
//

import UIKit

class SportNewsCell: UICollectionViewCell {
    
    let imageCache = ImageCache()
    
    static let reuseID = "SportsCell"
    
    let placeholder = "bbc"
    
    var sportsImage = UIImageView()
    var sportsNews = UILabel()
        
    var newValue: URLSessionDataTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newValue?.cancel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        
        addSubview(sportsImage)
        addSubview(sportsNews)
        
        sportsImage.translatesAutoresizingMaskIntoConstraints = false
        sportsNews.translatesAutoresizingMaskIntoConstraints  = false
        
        sportsImage.image = UIImage(named: placeholder)
        sportsNews.numberOfLines = 3
        sportsNews.adjustsFontSizeToFitWidth = true
        
        
        NSLayoutConstraint.activate([
        
            sportsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            sportsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            sportsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            sportsImage.heightAnchor.constraint(equalTo: sportsImage.widthAnchor, multiplier: 0.53),
            
            sportsNews.topAnchor.constraint(equalTo: sportsImage.bottomAnchor, constant: 20),
            sportsNews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            sportsNews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            sportsNews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        
        ])
    }
    
    func getImage(imgUrl: String?, key: String) {
        
        
//        guard let images = imgUrl else {return}
//        let cacheKey = NSString(string: images)
//
//        if let image1 = NewsCell.cache.object(forKey: cacheKey) {
//
//            self.sportsImage.image = image1
//            return
//
//        } else {
//
//            self.sportsImage.image = UIImage(named: placeholder)
//
//        }
        if let image = imageCache.getLocalImage(ket: key) {
            
            sportsImage.image = image
            return
        
        } else {
            sportsImage.image = UIImage(named: placeholder)
        }
        
        
        guard let baseUrl = imgUrl else {return}
        
        guard let endpoint = URL(string: baseUrl) else {return}
        
        let task = URLSession.shared.dataTask(with: endpoint) { [weak self] data, response, error in
            
            guard let self = self else { return }

            if error != nil  {return}
            
            guard let data = data else {return}
            guard let image = UIImage(data: data) else {return}
            
            //NewsCell.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.global(qos: .background).async {
                self.imageCache.store(image: image, key: key)
                DispatchQueue.main.async {
                    self.sportsImage.image = image
                }
            }
            
        }
        task.resume()
        self.newValue = task
    }
}




