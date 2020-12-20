//
//  ImageService.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 20.12.2020.
//
import UIKit

typealias ImageCompletionHandler = ((UIImage?) -> Void)?

class ImageService {
    static let imageCache = NSCache<NSString, AnyObject>()
    
    class func downloadImage(from url: URL?, completion: ImageCompletionHandler = nil) {
        guard let url = url else {
            completion?(nil)
            return
        }
        let cacheKey = NSString(string: url.absoluteString)
        if let cachedImage = imageCache.object(forKey: cacheKey) as? UIImage {
            completion?(cachedImage)
        } else {
            backgroundQueue {
                if let imageData = try? Data(contentsOf: url), let imageFromData = UIImage(data: imageData)
                {
                    mainQueue {
                        imageCache.setObject(imageFromData, forKey: cacheKey)
                        completion?(imageFromData)
                    }
                } else {
                    mainQueue { completion?(nil) }
                }
            }
            
        }
    }
}

