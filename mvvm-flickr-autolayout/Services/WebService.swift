//
//  WebService.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 20.12.2020.
//

import Foundation

internal typealias CompletionObjectHandler = ((Error?, AnyObject?) -> ())?
internal typealias CompletionAnyHandler = ((Error?, Any?) -> ())?

internal func mainQueue(_ block: @escaping ()->()) {
    DispatchQueue.main.async(execute: block)
}

internal func backgroundQueue(_ block: @escaping ()->()) {
    DispatchQueue.global(qos: .background).async(execute: block)
}

enum WebServiceError: Error {
    case invalidURL
    case invalidResponse
    case failedRequest
    case parseError
}

final class WebService {
    
    // MARK : - Constants
    
    let baseURL = "https://api.flickr.com/services/rest"
    
    // MARK: - Enumeration
    
    fileprivate enum APIMethod: String {
        case search = "flickr.photos.search"
        static func queryItem(method: APIMethod) -> URLQueryItem {
            switch method {
            case .search:
                return URLQueryItem(name: "method", value: method.rawValue)
            }
        }
    }
    
    fileprivate enum AuthMethod: String {
        case apiKey = "1508443e49213ff84d566777dc211f2a"
        static func queryItem(method: AuthMethod) -> URLQueryItem {
            switch method {
            case .apiKey:
                return URLQueryItem(name: "api_key", value: method.rawValue)
            }
        }
    }
    
    // MARK: - Enumat
    
    fileprivate enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    
    // MARK: - Load Methods
    
    public func loadSearchResultsServer(searchTerm: String, page: Int = 1, perPage: Int = 20, completion: CompletionObjectHandler = nil) {
        var queryItems: [URLQueryItem] = [
            AuthMethod.queryItem(method: .apiKey),
            APIMethod.queryItem(method: .search)
        ]
        
        let parameters: [String: Any] = [
            "extras": [
                "media",
                "url_sq",
                "url_m"
            ],
            "format": "json",
            "nojsoncallback": "true",
            "tags": searchTerm,
            "per_page": String(perPage),
            "page": String(page)
        ]
        
        queryItems.append(contentsOf: generateParameters(dictionary: parameters))
        
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else {
            completion?(WebServiceError.invalidURL, nil)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.executeRequest { (error, data) in
            if let error = error {
                completion?(error, nil)
            } else if let dictionary = data as? [String: Any] {
                let searchGroup = SearchGroup(with: dictionary)
                completion?(nil, searchGroup)
            } else {
                completion?(WebServiceError.invalidResponse, nil)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    fileprivate func generateParameters(dictionary: [String: Any]) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        for (key, value) in dictionary {
            if let value = value as? String {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            } else if let values = value as? [String] {
                for value in values {
                    let item = URLQueryItem(name: key, value: value)
                    queryItems.append(item)
                }
            }
        }
        return queryItems
    }
}

