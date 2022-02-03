//
//  NewsDetails.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 1/18/22.
//

import UIKit

class NewsDetails: UIViewController {
    
    let imageDownload = ImageManipulation()
    let cacheImage = ImageCache()
    
    var imageName: String
    var dataofImage: String
        
    init(imageName: String, dataofImage: String) {
        self.imageName = imageName
        self.dataofImage = dataofImage
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageDetails = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        configureDetails()
        showImage(image: dataofImage, title: imageName)
        
    }
    
    
    func configureDetails() {
        
        view.addSubview(imageDetails)
        imageDetails.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            imageDetails.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageDetails.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageDetails.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageDetails.heightAnchor.constraint(equalTo: imageDetails.widthAnchor, multiplier: 0.56)

        ])
 
    }
    
    func showImage(image: String, title: String) {
        
        if let image = cacheImage.getLocalImage(ket: title) {
            DispatchQueue.main.async {
                self.imageDetails.image = image
            }
            return
        }

        guard let imageData = imageDownload.loadImage(imageUrl: image) else {return}
        DispatchQueue.main.async {
            self.imageDetails.image = UIImage(data: imageData, scale: UIScreen.main.scale)
        }
    }

}
