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
        getSporstNews()
        navigationController?.navigationBar.barTintColor = .systemRed
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
        
        collectioView = UICollectionView(frame: view.bounds, collectionViewLayout: FlowlayutClass.flowLayoutConfigure(in: view))
        view.addSubview(collectioView)
        collectioView.delegate = self
        collectioView.dataSource = self
        collectioView.backgroundColor = .systemRed
        collectioView.register(SportNewsCell.self, forCellWithReuseIdentifier: SportNewsCell.reuseID)
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


