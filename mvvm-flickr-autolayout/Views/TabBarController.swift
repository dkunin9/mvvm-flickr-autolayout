//
//  MainController.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 19.12.2020.
//

import UIKit

class MainTabController: UITabBarController {
    
    override func viewDidLoad() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barStyle = .black
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor.orange
        
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.tabBar.layer.shadowRadius = 10
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.masksToBounds = false
    }
    
    var coordinator: TabBarCoordinator?
    
}
