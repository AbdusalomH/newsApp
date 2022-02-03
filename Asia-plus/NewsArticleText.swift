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
    let scrolViewofImage = UIScrollView()
    
  
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
        doneButton()
    }
    
    
    func doneButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(sideMenu))
        
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func sideMenu() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func configureNews(){
        
        view.addSubview(scrolViewofImage)
        scrolViewofImage.addSubview(newsImage)
        
        //view.addSubview(newsImage)
        view.addSubview(contentTitle)
        view.addSubview(contentText)
        
        
        newsImage.image = UIImage(named: "bbc")
        contentTitle.text = "BBC news"
        contentText.text = "text of news should be here"
        

        
        
        
        newsImage.translatesAutoresizingMaskIntoConstraints         = false
        contentText.translatesAutoresizingMaskIntoConstraints       = false
        contentTitle.translatesAutoresizingMaskIntoConstraints      = false
        scrolViewofImage.translatesAutoresizingMaskIntoConstraints  = false
        
        NSLayoutConstraint.activate([
            
            scrolViewofImage.topAnchor.constraint(equalTo: view.topAnchor),
            scrolViewofImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrolViewofImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrolViewofImage.heightAnchor.constraint(equalTo: newsImage.widthAnchor),
        
            newsImage.topAnchor.constraint(equalTo: scrolViewofImage.topAnchor, constant: 10),
            newsImage.leadingAnchor.constraint(equalTo: scrolViewofImage.leadingAnchor, constant: 10),
            newsImage.trailingAnchor.constraint(equalTo: scrolViewofImage.trailingAnchor, constant: -10),
            newsImage.heightAnchor.constraint(equalTo: scrolViewofImage.widthAnchor),
            
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
