//
//  MainTabCoordinator.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 19.12.2020.
//

import UIKit

class MainTabCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainTabController = MainTabController()
        mainTabController.coordinator = self
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let searchCoordinator = SearchCoordinator(navigationController: searchNavigationController)
        
        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        

        mainTabController.viewControllers = [searchNavigationController,
                                            profileNavigationController]
        
        mainTabController.modalPresentationStyle = .fullScreen
        navigationController.present(mainTabController, animated: true, completion: nil)
    
        
        coordinate(to: searchCoordinator)
        coordinate(to: profileCoordinator)
    }

}