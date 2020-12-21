//
//  SearchViewController.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 19.12.2020.
//

import UIKit

class SearchViewController: UIViewController {
   
   // MARK: - Private
    var didSetupConstraints = false
    
    var collectionView: UICollectionView!
    
    var searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: SearchListViewModel!
    
    var coordinator: SearchFlow?
    
   // MARK: - View Life Cycle
   
   override func viewDidLoad() {
        super.viewDidLoad()
        initializeSearchControllers()
        view.backgroundColor = .yellow
        navigationItem.title = "First"
   }
    

   
   // MARK: - Setup Views
   
   func initializeSearchControllers() {
       viewModel = SearchListViewModel(webService: WebService())
       let placeholderText = NSLocalizedString("Search Images", comment: "Search placeholder text")
       searchController.searchBar.placeholder = placeholderText
       searchController.searchResultsUpdater = self
       navigationItem.searchController = searchController
       navigationItem.hidesSearchBarWhenScrolling = false
       definesPresentationContext = true
   }
    
    func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .blue
        collectionView.contentInset.top = 20.0
        collectionView.contentInset.left = 20.0
        collectionView.contentInset.right = 20.0
        collectionView.contentInset.bottom = 20.0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isUserInteractionEnabled = true

        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewSafeArea()
        
        
        collectionView.register(FlickrPhotoCell.self, forCellWithReuseIdentifier: FlickrPhotoCell.identifier)
        
    }
    
    func setupBindings() {
        viewModel.needsRefresh.bind { [weak self] needsRefresh in
            if needsRefresh {
                self?.collectionView.reloadData()
            }
        }
        viewModel.loadError.bind { [weak self] error in
        self?.presentAlertForError(with: error)
        }
    }
    
}



//extension SearchViewController: UISearchBarDelegate {
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        collectionView.autoPinEdgesToSuperviewSafeArea()
//        }
//}


extension SearchViewController: UISearchResultsUpdating {
   func updateSearchResults(for searchController: UISearchController) {
    
    if !searchController.isActive {
        view.backgroundColor = .yellow
        collectionView.autoPinEdgesToSuperviewSafeArea()
            return
        }
    else {
        view.backgroundColor = .white
        print(searchController.searchBar.text!)
        guard let searchTerm = searchController.searchBar.text else { return }
        viewModel.searchTerm = searchTerm
        setupCollectionView()
        setupBindings()
    }
   }
}


extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let searchResultViewModel = viewModel.viewModels?[indexPath.item] else { return }
        coordinator?.coordinateToDetail(viewModel: searchResultViewModel)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.viewModels?.count ?? 0
    }
    
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlickrPhotoCell.identifier, for: indexPath) as! FlickrPhotoCell
        guard let childViewModel = viewModel?.viewModels?[indexPath.row] else { return cell }
        cell.backgroundColor = .green
        cell.viewModel = childViewModel
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let isLandscape = UIApplication.shared.statusBarOrientation.isLandscape
//        let cellPadding: CGFloat = 16.0
//        let cellWidth = (isLandscape ? (collectionView.frame.size.width / 5.0) : (collectionView.frame.size.width / 2.0)) - cellPadding
        let cellWidth = 150.0
        let cellHeight = cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

