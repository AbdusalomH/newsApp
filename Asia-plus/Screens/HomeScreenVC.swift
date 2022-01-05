//
//  HomeScreenVC.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 12/16/21.
//

import UIKit

class HomeScreenVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var mycollectionView: UICollectionView!
    
    var getNewsText: [Article] = [Article]()
    var menuCategory: [String] = [String]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "N E W S"
        
        configureCollectioView()
        getNews()
        mycollectionView.refreshControl = UIRefreshControl()
        mycollectionView.refreshControl?.addTarget(self, action: #selector(getRefresh), for: .valueChanged)
        
        navigationController?.navigationBar.barTintColor = .systemRed
        menuController()
    }
    
    
    func menuController() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "list.bullet"), style: .done, target: self, action: #selector(sideMenu))
        
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    
    @objc func sideMenu() {
        
        let sideMenu = NewsArticleText(url: "ok", articleTitle: "ok")
        
        navigationController?.pushViewController(sideMenu, animated: true)
        
    }
    
    
    @objc private func getRefresh() {
        getNews()
        DispatchQueue.main.async {
            self.mycollectionView.refreshControl?.endRefreshing()
            self.mycollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.backgroundColor = .systemBlue
//        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
//

    }
    
    func getNews() {
        self.getNewsText.removeAll()
        NetworkManager.shared.getNews { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
                case .success(let news):
                    let category = MenuCategory()
                    DispatchQueue.main.async {
                        self.getNewsText = news.articles
                        self.menuCategory = category.menu
                        self.mycollectionView.reloadData()
                    }
 
                case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureCollectioView() {
        
        let mainCollection: CGRect = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        mycollectionView = UICollectionView(frame: mainCollection, collectionViewLayout: flowLayoutConfigure())
        view.addSubview(mycollectionView)
        mycollectionView.delegate         = self
        mycollectionView.dataSource       = self
        mycollectionView.backgroundColor  = .systemRed
        mycollectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.reuseID)
        
        
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getNewsText.count
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = mycollectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseID, for: indexPath) as! NewsCell
        let newshere        = self.getNewsText[indexPath.item]
        cell.newsText.text  = newshere.title
        cell.downloadImage(data: newshere.urlToImage)
        return cell
        
    }
    
   
    func flowLayoutConfigure() -> UICollectionViewLayout {
        let width                   = view.bounds.width
        let usedPadding: CGFloat    = 10
        let availableSpace: CGFloat = width - usedPadding
        let flowLayout              = UICollectionViewFlowLayout()
        flowLayout.sectionInset     = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.itemSize         = CGSize(width: availableSpace, height: 270)
        return flowLayout
    
    }
}



