//
//  DetailsViewController.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 20.12.2020.
//

import UIKit
import PureLayout

class DetailsViewController: UIViewController {

    // MARK: - Variables

    var viewModel: SearchResultViewModel!

    var didSetupConstraints = false
    
    var scrollView = UIScrollView.newAutoLayout()
    var containerView = UIView.newAutoLayout()
    
    // MARK: - Lazy Inits

    let flickrImageView: UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    let labelTitle: UILabel = {
        let label = UILabel.newAutoLayout()
        label.lineBreakMode = .byClipping
        label.backgroundColor = .white
        label.numberOfLines = 1
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.text = "Title"
        label.textAlignment = .left
        return label
    }()
    
    

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func updateContent() {
        if (viewModel.title == "") {
            labelTitle.text = "Title not given"
        }
        else {
            labelTitle.text = viewModel.title
        }
        guard let imageURL = viewModel?.imageURL else { return }
        ImageService.downloadImage(from: imageURL) { [self] image in
            flickrImageView.image = image
        }
    }

}


extension DetailsViewController {

    override func loadView() {
        super.viewDidLoad()
        view = UIView()

        view.addSubview(scrollView)
        
        view.backgroundColor = .white
        scrollView.backgroundColor = .white
        containerView.backgroundColor = .white
        
        scrollView.addSubview(containerView)
        containerView.addSubview(labelTitle)
        containerView.addSubview((flickrImageView))
        
        
        navigationItem.title = "Details screen"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        updateContent()
   }

    
    override func viewDidLayoutSubviews() {
            view.setNeedsUpdateConstraints()
        }


    override func updateViewConstraints() {

        if (!didSetupConstraints) {

            scrollView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)

            containerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
            containerView.autoMatch(.width, to: .width, of: view)
            
            labelTitle.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
            labelTitle.autoAlignAxis(toSuperviewAxis: .vertical)
            flickrImageView.autoPinEdge(.top, to: .bottom, of: labelTitle, withOffset: 20)
            flickrImageView.autoMatch(.width, to: .width, of: view)
            
            
            didSetupConstraints = true
      }
   super.updateViewConstraints()
  }
}
