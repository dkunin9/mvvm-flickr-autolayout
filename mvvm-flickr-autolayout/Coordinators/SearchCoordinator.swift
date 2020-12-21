//
//  SearchCoordinator.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 19.12.2020.
//

import UIKit

protocol SearchFlow: class {
    func coordinateToDetail(viewModel: SearchResultViewModel)
}


class SearchCoordinator: Coordinator, SearchFlow {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = SearchViewController()
        searchViewController.coordinator = self
        navigationController?.pushViewController(searchViewController, animated: true)
        navigationController?.navigationBar.barTintColor = .gray
        
    }
    
    func coordinateToDetail(viewModel: SearchResultViewModel) {
        let detailsViewController = DetailsViewController()
        detailsViewController.viewModel = viewModel
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
