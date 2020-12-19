//
//  SearchViewController.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 19.12.2020.
//

import UIKit
import PureLayout

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {

    }
    var didSetupConstraints = false
    
    private var collectionView: UICollectionView!
    private var _searchController : UISearchController?
    
    func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.contentInset.top = 8.0
        collectionView.contentInset.left = 8.0
        collectionView.contentInset.right = 8.0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
    }
    
    override func viewDidLoad() {
        navigationItem.title = "First Tab"
        view.backgroundColor = .yellow
        initializeSearchControllers()
        super.viewDidLoad()
    }
    
    
    func initializeSearchControllers() {
        let searchController = UISearchController(searchResultsController: nil)
        _searchController = searchController
        let placeholderText = NSLocalizedString("Search images", comment: "")
        searchController.searchBar.placeholder = placeholderText
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}
