//
//  DetailsCoordinator.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 20.12.2020.
//

//import UIKit
//
//protocol DetailsFlow: class {
//    func dismissDetail()
//}
//
//class DetailsCoordinator: Coordinator, DetailsFlow {
//    let navigationController: UINavigationController
//    
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//    
//    func start() {
//        let detailsViewController = DetailsViewController()
//        detailsViewController.coordinator = self
//        navigationController.present(detailsViewController, animated: true, completion: nil)
//        
//        navigationController.pushViewController(detailsViewController, animated: false)
//    }
//    
////    // MARK: - Flow Methods
//    func dismissDetail() {
//        navigationController.popToRootViewController(animated: true)
////        navigationController.dismiss(animated: true, completion: nil)
//    }
//}
