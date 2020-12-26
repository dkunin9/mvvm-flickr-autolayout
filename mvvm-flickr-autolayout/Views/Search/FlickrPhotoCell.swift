//
//  FlickrPhotoCell.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 20.12.2020.
//

import UIKit
import PureLayout

class FlickrPhotoCell: UICollectionViewCell {
  
    // MARK: - Variables
    
    static let identifier = "FlickrPhotoCell"
    
    // MARK: - Lazy variables
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinnerView = UIActivityIndicatorView.newAutoLayout()
        spinnerView.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView.backgroundColor = .red
        spinnerView.contentMode = .scaleAspectFit
        spinnerView.color = .gray
        spinnerView.center = CGPoint(x: contentView.frame.size.width / 2, y: contentView.frame.size.height / 2)
        return spinnerView
    }()
    
    lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        imageView.frame.size.width = 150
        imageView.frame.size.height = 150
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    
    var viewModel: SearchResultViewModel? {
        didSet {
            updateContent()
        }
    }
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setUpViews(){
        addViews()
    }

    fileprivate func addViews(){
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(spinner)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
    
    /*
     Download image from ViewModel URL
     Stop spinner animation if image is downloaded
     */
    func updateContent() {
        guard let viewModel = viewModel, let imageURL = viewModel.imageURL else { return }
        ImageService.downloadImage(from: imageURL) { [self] image in
            spinner.stopAnimating()
            thumbnailImageView.image = image
        }
    }

}
