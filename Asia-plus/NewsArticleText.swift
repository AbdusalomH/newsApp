//
//  NewsArticleText.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 12/19/21.
//

import UIKit

class NewsArticleText: UIViewController {
    
    let url: String
    let articleTitle: String
    let articleText: String = ""
    
    let newsImage = UIImageView()
    let contentTitle = UILabel()
    let contentText = UILabel()
    
  
    init(url:String, articleTitle: String) {
        self.url = url
        self.articleTitle = articleTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNews()
        view.backgroundColor = .systemYellow
    }
    
    func configureNews(){
        
        view.addSubview(newsImage)
        view.addSubview(contentTitle)
        view.addSubview(contentText)
        
        
        newsImage.image = UIImage(named: "bbc")
        contentTitle.text = "BBC news"
        contentText.text = "text of news should be here"
        
        newsImage.translatesAutoresizingMaskIntoConstraints     = false
        contentText.translatesAutoresizingMaskIntoConstraints   = false
        contentTitle.translatesAutoresizingMaskIntoConstraints  = false
        
        NSLayoutConstraint.activate([
        
            newsImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            newsImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            newsImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            newsImage.heightAnchor.constraint(equalTo: newsImage.widthAnchor),
            
            contentTitle.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 20),
            contentTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentTitle.heightAnchor.constraint(equalToConstant: 50),
            
            contentText.topAnchor.constraint(equalTo: contentTitle.bottomAnchor, constant: 20),
            contentText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentText.heightAnchor.constraint(equalToConstant: 300)

        ])
    }
}
