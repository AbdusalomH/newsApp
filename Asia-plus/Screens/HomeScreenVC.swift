//
//  HomeScreenVC.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 12/16/21.
//

import UIKit

class HomeScreenVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    var mycollectionView: UICollectionView!
    
    var getNewsText: [Article] = [Article]()
    var menuCategory: [String] = [String]()
    
 
 override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "N E W S"
        
        configureCollectioView()
        getNews2()
        mycollectionView.refreshControl = UIRefreshControl()
        mycollectionView.refreshControl?.addTarget(self, action: #selector(getRefresh), for: .valueChanged)
        view.backgroundColor = .systemGray5
        navigationController?.navigationBar.tintColor = .systemBackground
        
        menuController()

    }
    

    
    func menuController() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "list.bullet"), style: .done, target: self, action: #selector(sideMenu))
        
        navigationItem.leftBarButtonItem?.tintColor = .systemGray2
    }
    
    
    @objc func sideMenu() {
        
        let sideMenu = Test()
                
        navigationController?.pushViewController(sideMenu, animated: true)
        
    }
    
    
    @objc private func getRefresh() {
        
        DispatchQueue.main.async {
            self.getNews2()
            self.mycollectionView.refreshControl?.endRefreshing()
            self.mycollectionView.reloadData()
        }
    }
    
    
//    func getNews() {
//        self.getNewsText.removeAll()
//
//        NetworkManager.shared.getNews { [weak self] (result) in
//            guard let self = self else { return }
//
//            switch result {
//                case .success(let news):
//                    DispatchQueue.main.async {
//                        self.getNewsText = news.articles
//                        self.mycollectionView.reloadData()
//                    }
//
//                case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    func getNews2() {
        networkManager.getNews { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
                case .success(let news):
                    DispatchQueue.main.async {
                        self.getNewsText = news.articles
                        self.mycollectionView.reloadData()
                    }
 
                case .failure(let error):
                print(error)
            }
        }
    }
   
    
    func configureCollectioView() {
        
        mycollectionView = UICollectionView(frame: .zero, collectionViewLayout: FlowlayutClass.flowLayoutConfigure(in: view))
        collectionViewPlacing()
        mycollectionView.delegate           = self
        mycollectionView.dataSource         = self
        mycollectionView.backgroundColor    = .systemGray5
        mycollectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.reuseID)
        
    }
 
    
    func collectionViewPlacing() {
        view.addSubview(mycollectionView)
        
        mycollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            mycollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            mycollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            mycollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            mycollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getNewsText.count
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = mycollectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseID, for: indexPath) as! NewsCell
        let newshere        = self.getNewsText[indexPath.item]
        cell.newsText.text  = newshere.title
        cell.downloadImage(data: newshere.urlToImage, title: newshere.title)
        
    
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let newsData = getNewsText[indexPath.row]
        guard let receivedImage = newsData.urlToImage else {return}
//        let newsDetails = NewsDetails(imageName: newsData.title, dataofImage: receivedImage)
//        navigationController?.pushViewController(newsDetails, animated: true)
        
        let newsDetail = ScrollViewController(imageName: receivedImage)
        navigationController?.pushViewController(newsDetail, animated: true)
    }
}



