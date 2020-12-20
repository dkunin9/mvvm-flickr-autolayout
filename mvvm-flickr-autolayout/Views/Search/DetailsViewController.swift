//
//  DetailsViewController.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 20.12.2020.
//

import UIKit

class DetailsViewController: UIViewController {

    // MARK: - Variables

    var viewModel: SearchResultViewModel!

    // MARK: - Lazy Inits

    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.frame.size.width = 150
        imageView.frame.size.height = 150
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Details screen"
        view.backgroundColor = .yellow
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        
        print(viewModel.imageURL)
        setupConstraints()
        
        updateContent()
    }
    
    func back() {
        coordinator?.dismissDetail()
            }
    
    var coordinator: DetailsFlow?

    // MARK: - Setup Views

    func setupConstraints() {
        view.addSubview(coverImageView)
//        var constraints: [NSLayoutConstraint] = []
//        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[coverImageView]|", options: [], metrics: nil, views: ["coverImageView": coverImageView]))
//        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|[coverImageView]|", options: [], metrics: nil, views: ["coverImageView": coverImageView]))
//        NSLayoutConstraint.activate(constraints)
    }

    func updateContent() {
        print(viewModel?.imageURL)
        guard let imageURL = viewModel?.imageURL else { return }
        ImageService.downloadImage(from: imageURL) { [weak self] image in
            self?.coverImageView.image = image
            print(image!)
        }
    }

}
