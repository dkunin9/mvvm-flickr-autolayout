//
//  ProfileCoordinator.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 19.12.2020.
//

import UIKit

class ProfileCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let profileViewController = ProfileViewController()
        navigationController.pushViewController(profileViewController, animated: true)
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.barTintColor = .black
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    

}
