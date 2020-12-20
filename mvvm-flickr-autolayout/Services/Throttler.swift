//
//  Throttle.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 20.12.2020.
//

import UIKit

class Throttler {
    
    // MARK: - Variables
    
    fileprivate let backgroundQueue = DispatchQueue.global(qos: .background)
    fileprivate var pendingWorkItem: DispatchWorkItem = DispatchWorkItem(block: {})
    fileprivate var lastJobDate: Date = Date.distantPast
    fileprivate var interval: Double
    
    // MARK: - Life Cycle
    
    init(seconds: Double) {
        self.interval = seconds
    }
    
    // MARK: - Methods
    
    func throttle(block: @escaping () -> ()) {
        pendingWorkItem.cancel()
        pendingWorkItem = DispatchWorkItem() { [weak self] in
            self?.lastJobDate = Date()
            block()
        }
        let delay = Double(Date().timeIntervalSince(lastJobDate).rounded()) > interval ? 0 : interval
        backgroundQueue.asyncAfter(deadline: .now() + delay, execute: pendingWorkItem)
    }
}
