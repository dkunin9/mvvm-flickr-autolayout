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
        searchNavigationController.tabBarItem = UITabBarItem(title: "First tab", image: nil, tag: 0)
        searchNavigationController.tabBarItem.accessibilityIdentifier = AccessibilityIdentifiers.FirstTab
        let searchCoordinator = SearchCoordinator(navigationController: searchNavigationController)
        
        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem(title: "Second tab", image: nil, tag: 1)
        profileNavigationController.tabBarItem.accessibilityIdentifier = AccessibilityIdentifiers.SecondTab
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        

        mainTabController.viewControllers = [searchNavigationController,
                                            profileNavigationController]
        
        navigationController.pushViewController(mainTabController, animated: true)
        navigationController.isNavigationBarHidden = true
        
        coordinate(to: searchCoordinator)
        coordinate(to: profileCoordinator)
    }

}
