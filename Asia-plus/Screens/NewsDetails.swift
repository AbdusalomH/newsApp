//
//  NewsDetails.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 1/18/22.
//

import UIKit

class NewsDetails: UIViewController, UIScrollViewDelegate {
    
    
    let imageDownload = ImageManipulation()
    let cacheImage = ImageCache()
    
    var imageName: String
    var dataofImage: String
    
    
    var compactConstrait = [NSLayoutConstraint]()
    var regularConstrait = [NSLayoutConstraint]()
    
    
    init(imageName: String, dataofImage: String) {
        self.imageName = imageName
        self.dataofImage = dataofImage

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageDetails = UIImageView()
    let imageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        configureDetails()
        showImage(image: dataofImage, title: imageName)
        
        enableSizeClassConstraint(horizontalClass: traitCollection.horizontalSizeClass)

    }

    
    func configureDetails() {
        
        view.addSubview(imageDetails)
        view.addSubview(imageLabel)
        
        imageDetails.translatesAutoresizingMaskIntoConstraints = false
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
                
        imageLabel.numberOfLines = 0
   
    }
    
    func compactPosition() -> [NSLayoutConstraint] {
        
        compactConstrait.append(imageDetails.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        compactConstrait.append(imageDetails.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor))
        compactConstrait.append(imageDetails.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        compactConstrait.append(imageDetails.heightAnchor.constraint(equalTo: imageDetails.widthAnchor, multiplier: 0.56))
        
        compactConstrait.append(imageLabel.topAnchor.constraint(equalTo: imageDetails.bottomAnchor, constant: 20))
        compactConstrait.append(imageLabel.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        compactConstrait.append(imageLabel.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        compactConstrait.append(imageLabel.heightAnchor.constraint(equalToConstant: 70))
        
        return compactConstrait
    }
    

    
    func regularPosition() -> [NSLayoutConstraint] {
        
        regularConstrait.append(imageDetails.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20))
        regularConstrait.append(imageDetails.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        regularConstrait.append(imageDetails.heightAnchor.constraint(equalToConstant: 200))
        regularConstrait.append(imageDetails.widthAnchor.constraint(equalToConstant: 200))
        
        regularConstrait.append(imageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30))
        regularConstrait.append(imageLabel.leadingAnchor.constraint(equalTo: imageDetails.trailingAnchor, constant: 20))
        regularConstrait.append(imageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        regularConstrait.append(imageLabel.heightAnchor.constraint(equalToConstant: 200))
        
        
        return regularConstrait

    }
    
    func enableSizeClassConstraint(horizontalClass: UIUserInterfaceSizeClass) {
        
        if horizontalClass == .compact {
            
            NSLayoutConstraint.deactivate(regularPosition())
            NSLayoutConstraint.activate(compactPosition())
            
        } else {
            
            NSLayoutConstraint.deactivate(compactPosition())
            NSLayoutConstraint.activate(regularPosition())
            
        }
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass {
            enableSizeClassConstraint(horizontalClass: traitCollection.horizontalSizeClass)
        }
    }
    

    
    func showImage(image: String, title: String) {
        
        if let image = cacheImage.getLocalImage(ket: title) {
            DispatchQueue.main.async {
                self.imageDetails.image = image
                self.imageLabel.text = title
            }
            return
        }

        guard let imageData = imageDownload.loadImage(imageUrl: image) else {return}
        
        DispatchQueue.main.async {
            self.imageDetails.image = UIImage(data: imageData, scale: UIScreen.main.scale)
        }
    }
}


