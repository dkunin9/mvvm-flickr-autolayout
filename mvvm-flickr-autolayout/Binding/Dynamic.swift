//
//  Dynamic.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 20.12.2020.
//

import Foundation
import UIKit

/**
## Dynamic<T>

This class is a lightweight single binding for this MVVM implementation, which can be expanded in the future if need be.

*/
class Dynamic<T> {

    typealias Listener = (T) -> Void
    
    // MARK: - Variables

    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    // MARK: - Life Cycle

    init(_ value: T) {
        self.value = value
    }

    // MARK: - Methods

    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}

extension UIViewController {

    func presentAlertForError(with error: Error?) {
        guard let error = error else { return }
        let errorTitle = NSLocalizedString("Oops.. Something went wrong. 😥", comment: "Error alert title")
        let alert = UIAlertController(title: errorTitle, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

}

