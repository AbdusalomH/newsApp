//
//  SportsVC.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 12/30/21.
//

import UIKit

class SportsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    var collectioView: UICollectionView!
    
    var sportsData: [Results] = [Results]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "S p o r t s"
        
        configureCollectioView()
        placeCollectioView()
        getSporstNews()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.barTintColor = .systemBackground
        collectioView.refreshControl = UIRefreshControl()
        collectioView.refreshControl?.addTarget(self, action: #selector(reloadNews), for: .valueChanged)
    }
    
    @objc func reloadNews() {
        getSporstNews()
        DispatchQueue.main.async {
            self.collectioView.refreshControl?.endRefreshing()
            self.collectioView.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sportsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportNewsCell.reuseID, for: indexPath) as! SportNewsCell
        
        let sports = sportsData[indexPath.item]
        
        cell.getImage(imgUrl: sports.imageUrl, key: sports.title)
        cell.sportsNews.text = sports.title
        
        return cell
    }
    
    
    func configureCollectioView() {
        
        collectioView = UICollectionView(frame: .zero, collectionViewLayout: FlowlayutClass.flowLayoutConfigure(in: view))
        
        collectioView.delegate = self
        collectioView.dataSource = self
        collectioView.backgroundColor = .systemGray2
        collectioView.register(SportNewsCell.self, forCellWithReuseIdentifier: SportNewsCell.reuseID)
    }
    
    
    func placeCollectioView() {
        
        view.addSubview(collectioView)
        
        collectioView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            collectioView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            collectioView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            collectioView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            collectioView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
        
    }
    
    
//    func flowLayoutConfigure() -> UICollectionViewLayout {
//
//        let width                       = view.bounds.width
//        let availableWidth: CGFloat     = width - 20
//
//        let flowlayut                   = UICollectionViewFlowLayout()
//        flowlayut.scrollDirection       = .vertical
//        flowlayut.sectionInset          = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        flowlayut.itemSize              = CGSize(width: availableWidth, height: 270)
//
//        return flowlayut
//
//    }
    
    
    func getSporstNews() {
        
        NetworkManager.shared.getSportNews { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let sports):
                DispatchQueue.main.async {
                    self.sportsData = sports.results
                    self.collectioView.reloadData()
                }
            case .failure(let error):
                print(error)
            
            }
        }
    }
}


