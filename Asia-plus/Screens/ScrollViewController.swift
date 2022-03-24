//
//  ScrollViewController.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 3/23/22.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {
    
    
    static let imageLoad = ImageManipulation()
    
    var imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let myscrollView = UIScrollView()
    let imageDetail = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
 
        myscrollView.delegate = self
        
        myscrollView.maximumZoomScale = 6
        
        view.backgroundColor = .systemGray4
        
        configureScrollView()
        configureViews()
        imageData(imageUrl: imageName)
        
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imageDetail
    }

    
    func configureScrollView() {
        
        view.addSubview(myscrollView)
        
        myscrollView.translatesAutoresizingMaskIntoConstraints = false
        
        myscrollView.showsVerticalScrollIndicator = false
        myscrollView.showsHorizontalScrollIndicator = false
        
        
        
        let frameLayout = myscrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
        
            frameLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            frameLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameLayout.heightAnchor.constraint(equalTo: frameLayout.widthAnchor, multiplier: 0.55)

        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myscrollView.setZoomScale(1.5, animated: true)
        print("Коснулся")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        myscrollView.setZoomScale(1, animated: true)
        print("Отпустил")
    }
    
    
    func configureViews() {
        
        myscrollView.addSubview(imageDetail)
        
        
        imageDetail.translatesAutoresizingMaskIntoConstraints = false
        
        imageDetail.image = UIImage(named: "logo")
        
        imageDetail.contentMode = .scaleAspectFit
        imageDetail.clipsToBounds = true
        
        
        let contentLayout = myscrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            imageDetail.widthAnchor.constraint(equalTo: myscrollView.widthAnchor),
            imageDetail.heightAnchor.constraint(equalTo: myscrollView.heightAnchor),
            imageDetail.topAnchor.constraint(equalTo: contentLayout.topAnchor),
            imageDetail.leadingAnchor.constraint(equalTo: contentLayout.leadingAnchor),
            imageDetail.trailingAnchor.constraint(equalTo: contentLayout.trailingAnchor),
            imageDetail.bottomAnchor.constraint(equalTo: contentLayout.bottomAnchor)

        ])
   
    }
    
    func imageData(imageUrl: String)  {
        
    
        imageDetail.image = UIImage(named: "logo")
        
        guard let imageData = Self.imageLoad.loadImage(imageUrl: imageUrl) else {return}
        
        DispatchQueue.main.async {
                self.imageDetail.image = UIImage(data: imageData, scale: UIScreen.main.scale)
        }
  
    }
}
