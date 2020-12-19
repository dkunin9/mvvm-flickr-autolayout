//
//  ProfileViewController.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 19.12.2020.
//

import UIKit
import PureLayout

class ProfileViewController: UIViewController {
    
    var didSetupConstraints = false

    var scrollView = UIScrollView.newAutoLayout()
    var containerView = UIView.newAutoLayout()

    let avatarWidth = 150
    let avatarHeight = 150

    let avatar: UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        imageView.image = UIImage(named: "avatar.jpg")
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    
    let labelFirstName: UILabel = {
        let label = UILabel.newAutoLayout()
        label.backgroundColor = .blue
        label.numberOfLines = 5
        label.lineBreakMode = .byClipping
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Daniil"
        label.textAlignment = .left
        return label
    }()
    
    
    let labelLastName: UILabel = {
        let label = UILabel.newAutoLayout()
        label.backgroundColor = .blue
        label.numberOfLines = 1
//        label.lineBreakMode = .byClipping
        label.textColor = .white
//        label.preferredMaxLayoutWidth = 150/2
//        label.minimumScaleFactor = 0.5
//        label.lineBreakMode = .byTruncatingTail
       // label.font = UIFont.systemFont(ofSize: 16)
//        label.font = label.font.withSize(label.frame.height * 2/3)
        label.adjustsFontSizeToFitWidth = true
        label.text = "Kunin"
        label.textAlignment = .left
        return label
    }()
    
    
    let labelHeader: UILabel = {
        let label = UILabel.newAutoLayout()
        label.backgroundColor = .blue
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.text = "BIO"
        return label
    }()
    
    
    
    let labelBio: UILabel = {
        let label = UILabel.newAutoLayout()
        label.backgroundColor = .blue
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.textColor = .white
        label.text = NSLocalizedString("I want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in ElectroluxI want to work in Electrolux", comment: "")
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProfileViewController {

    override func loadView() {
        super.viewDidLoad()
        view = UIView()

        view.addSubview(scrollView)
        
        view.backgroundColor = .white
        scrollView.backgroundColor = .white
        containerView.backgroundColor = .white
        
        scrollView.addSubview(containerView)
        containerView.addSubview(avatar)
        containerView.addSubview(labelFirstName)
        containerView.addSubview(labelLastName)
        containerView.addSubview(labelHeader)
        containerView.addSubview(labelBio)
        navigationItem.title = "Second Tab"
   }

    
    override func viewDidLayoutSubviews() {
            view.setNeedsUpdateConstraints()
        }


    override func updateViewConstraints() {

        if (!didSetupConstraints) {

            scrollView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
            print(scrollView.contentSize)

            containerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
            containerView.autoMatch(.width, to: .width, of: view)


            avatar.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
            avatar.autoSetDimension(.height, toSize: CGFloat(avatarHeight))
            avatar.autoSetDimension(.width, toSize: CGFloat(avatarWidth))
            avatar.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
            

            
            labelFirstName.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
            labelFirstName.autoPinEdge(.leading, to: .trailing, of: avatar, withOffset: 20)
            labelFirstName.autoSetDimension(.width, toSize: CGFloat(avatarWidth/2))

            labelLastName.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
            labelLastName.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
            labelLastName.autoSetDimension(.width, toSize: CGFloat(avatarWidth/2))
            
            
            labelHeader.autoPinEdge(.top, to: .bottom, of: avatar, withOffset: 10)
            labelHeader.autoAlignAxis(toSuperviewAxis: .vertical)
            
            
            labelBio.autoPinEdge(.top, to: .bottom, of: labelHeader, withOffset: 10)
            labelBio.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
            labelBio.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
            labelBio.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
            

            didSetupConstraints = true
      }
   super.updateViewConstraints()
  }
}
