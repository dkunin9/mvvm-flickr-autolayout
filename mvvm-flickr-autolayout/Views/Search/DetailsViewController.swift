//
//  DetailsViewController.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 20.12.2020.
//

import UIKit
import PureLayout

class DetailsViewController: UIViewController {
    
    var viewModel: SearchResultViewModel!

    var didSetupConstraints = false
    
    var scrollView = UIScrollView.newAutoLayout()
    var containerView = UIView.newAutoLayout()
    

    // MARK: - Lazy variables
    
    lazy var flickrImageView: UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    lazy var labelTitle: UILabel = {
        let label = UILabel.newAutoLayout()
        label.lineBreakMode = .byClipping
        label.backgroundColor = .white
        label.numberOfLines = 3
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.text = "Title"
        label.textAlignment = .center
        return label
    }()
    

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Methods
    
    /*
     downloading image to self
     */
    func updateContent() {
        if (viewModel.title == "") {
            labelTitle.text = "Title not given"
        }
        else {
            labelTitle.text = viewModel.title
        }
        guard let imageURL = viewModel?.imageURL else { return }
        ImageService.downloadImage(from: imageURL) { [weak self] image in
            self?.flickrImageView.image = image
        }
    }
    
    
    //MARK: - Save image

    @objc func saveImage() {
        guard let selectedImage = flickrImageView.image else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    //MARK: - Save Image callback

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {

        if let error = error {
            print(error.localizedDescription)
        } else {
            let refreshAlert = UIAlertController(title: "Great!", message: "The image was successfully saved", preferredStyle: .alert)
            refreshAlert.view.accessibilityIdentifier = "Good"
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Ok logic here")
              }))
            present(refreshAlert, animated: true, completion: nil)
            print("Successfully saved")
        }
    }
}


extension DetailsViewController {

    override func loadView() {
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save image", style: .plain, target: self, action: #selector(saveImage))
        navigationController?.tabBarController?.tabBar.isHidden = true
        
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
            labelTitle.autoMatch(.width, to: .width, of: view)
            labelTitle.autoAlignAxis(toSuperviewAxis: .vertical)
            
            flickrImageView.autoPinEdge(.top, to: .bottom, of: labelTitle, withOffset: 20)
            flickrImageView.autoMatch(.width, to: .width, of: view)
            
            didSetupConstraints = true
      }
   super.updateViewConstraints()
    }
}
