//
//  SearchListViewModel.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 19.12.2020.
//


import UIKit

class SearchListViewModel {
    
    // MARK: - Static Variables
    
    static var imageCache = NSCache<NSString, AnyObject>()
    
    // MARK: - Dynamic Variables
    
    var needsRefresh: Dynamic<Bool> = Dynamic(false) {
        didSet {
            needsRefresh.value = false // Reset Flag
        }
    }
    
    var loadError: Dynamic<Error?> = Dynamic(nil)
    
    // MARK: - Public Variables
    
    var canLoadMore: Bool = true
    
    // MARK: - Property Observers
    
    var searchTerm: String = "" {
        didSet {
            didUpdateSearchTerm()
        }
    }
    
    var viewModels: [SearchResultViewModel]? = nil {
        didSet {
            needsRefresh.value = true
        }
    }
    
    // MARK: - Fileprivate
    
    fileprivate let interval: Double = 1.5
    fileprivate var webService: WebService!
    var searchGroup: SearchGroup?
    
    // MARK: - Lazy Inits
    
    fileprivate lazy var throttler: Throttler = {
        let requestThrottler = Throttler(seconds: interval)
        return requestThrottler
    }()
    
    // MARK: - Life Cycle
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    // MARK: - Helper Methods
    
    func didUpdateSearchTerm() {
        guard searchTerm != "" else { return }
        throttler.throttle { [unowned self] in
            self.loadSearchResults(with: self.searchTerm, clearResults: true)
        }
    }
    
    func loadMoreResults() {
        guard canLoadMore else { return }
        loadSearchResults(with: searchTerm, clearResults: false)
    }
    
}

extension SearchListViewModel {
    
    // MARK: - Networking
    
    /**
     This method loads the search results and populate the child view models. The requests are throttled to prevent excess requests.
     
     - parameter query: the search term
     - parameter completion: returns a closure with error and
     */
    func loadSearchResults(with query: String, enableThrottling: Bool = false, clearResults: Bool = false) {
        let currentPage = searchGroup?.page ?? 0
        let nextPage = currentPage + 1
        webService.loadSearchResultsServer(searchTerm: query, page: nextPage) { [weak self] error, searchGroup in
            guard let self_ = self else { return }
            guard error == nil else {
                self_.loadError.value = error
                return
            }
            if let searchGroup = searchGroup as? SearchGroup, let searchResults = searchGroup.searchResults {
                var viewModels = [SearchResultViewModel]()
                for searchResult in searchResults {
                    let viewModel = SearchResultViewModel(searchResult: searchResult)
                    viewModels.append(viewModel)
                }
                if clearResults {
                    self_.viewModels = viewModels
                } else {
                    self_.viewModels?.append(contentsOf: viewModels)
                }
                self_.searchGroup = searchGroup
            } else {
                self_.canLoadMore = false // Loaded last page
            }
        }
    }
}
