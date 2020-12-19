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
        self.tabBar.barTintColor = .black
        self.tabBar.tintColor = .white
    }
    
    var coordinator: MainTabCoordinator?
    
}
