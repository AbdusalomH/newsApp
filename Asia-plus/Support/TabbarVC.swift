//
//  TabbarVC.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 1/9/22.
//

import UIKit


class TabbarVC: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [mainVC(), navBarPolitics(), navBarSports()]
        tabBar.tintColor = .red

    }
    
    func navBarPolitics() -> UINavigationController {
        
        let navPolitics = PoliticsVC()
        
        navPolitics.tabBarItem = UITabBarItem(title: "P o l i t i c s", image: UIImage(systemName: "pencil.circle"), selectedImage: UIImage(systemName: "pencil.circle.fill"))
        
        return UINavigationController(rootViewController: navPolitics)
        
    }
    
    
    func navBarSports() -> UINavigationController {
        
        let navSports = SportsVC()
        
        navSports.tabBarItem = UITabBarItem(title: "S p o r t s", image: UIImage(systemName: "sportscourt"), selectedImage: UIImage(systemName: "sportscourt.fill"))
        
        return UINavigationController(rootViewController: navSports)
    }
    
    
    func mainVC() -> UINavigationController {
        
        let mainVC = HomeScreenVC()
        
        mainVC.tabBarItem = UITabBarItem(title: "N E W S ", image: UIImage(systemName: "books.vertical"), selectedImage: UIImage(systemName: "books.vertical.fill"))
        
        return UINavigationController(rootViewController: mainVC)
    }
    
    
}