//
//  SearchViewController.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 19.12.2020.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Variables
   
    var didSetupConstraints = false
    
    var collectionView: UICollectionView!
    
    var searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: SearchListViewModel!
    
    var coordinator: SearchFlow?
    
   // MARK: - View Life Cycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSearchControllers()
        view.backgroundColor = .white
        navigationItem.title = "First"
        
        // init CollectionView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
    }
   
   // MARK: - Methods
   
    func initializeSearchControllers() {
        
        viewModel = SearchListViewModel(webService: WebService())
        let placeholderText = NSLocalizedString("Search Images", comment: "Search placeholder text")
        searchController.searchBar.placeholder = placeholderText
        searchController.searchResultsUpdater = self
        searchController.searchBar.backgroundColor = .gray
        searchController.searchBar.tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.contentInset.top = 20.0
        collectionView.contentInset.left = 20.0
        collectionView.contentInset.right = 20.0
        collectionView.contentInset.bottom = 20.0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isUserInteractionEnabled = true
        
        // Init pin of collectionView
        collectionView.autoPinEdgesToSuperviewSafeArea()
        
        // Register cell class
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


// MARK: - Search term text updates

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
         // Repin collectionView after search controller misses focus
        if !searchController.isActive {
            collectionView.autoPinEdgesToSuperviewSafeArea()
            return
        }
        /*
         Pass search term to ViewModel
         Repin & init collectionView
         */
        else {
            view.backgroundColor = .white
            guard let searchTerm = searchController.searchBar.text else { return }
        
            if searchController.searchBar.text != "" {
                viewModel.searchTerm = searchTerm
                setupCollectionView()
                setupBindings()
            }
        }
    }
}

// MARK: - Item selection

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
    /*
     Pass ViewModel[index] to each cell of collectionView
     Start spinner animation
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlickrPhotoCell.identifier, for: indexPath) as! FlickrPhotoCell
        guard let childViewModel = viewModel?.viewModels?[indexPath.row] else { return cell }
        cell.viewModel = childViewModel
        if searchController.searchBar.text != "" {
            cell.spinner.startAnimating()
        }
        return cell
    }
}


extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // TODO: Autolayout cells size
        let cellWidth = 150.0
        let cellHeight = cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

