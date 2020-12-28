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

    
    // MARK: - Lazy variables
    
    lazy var avatar: UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        imageView.image = UIImage(named: "avatar.jpg")
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    
    lazy var labelFirstName: UILabel = {
        let label = UILabel.newAutoLayout()
        label.lineBreakMode = .byClipping
        label.backgroundColor = .white
        label.numberOfLines = 1
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.text = "Daniil"
        label.textAlignment = .left
        return label
    }()
    
    
    lazy var labelLastName: UILabel = {
        let label = UILabel.newAutoLayout()
        label.backgroundColor = .white
        label.numberOfLines = 1
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.text = "Kunin"
        label.textAlignment = .left
        return label
    }()
    
    
    lazy var labelHeader: UILabel = {
        let label = UILabel.newAutoLayout()
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.text = "BIO"
        return label
    }()
    
    
    lazy var labelBio: UILabel = {
        let label = UILabel.newAutoLayout()
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.textColor = .black
        label.text = NSLocalizedString("My name is Daniil. Last summer I completed an important stage in my life - I received a Bachelor’s degree from Peter the Great St. Petersburg Polytechnic University (SPbPU) in the field of control systems. During these interesting 4 years I have learned a lot of disciplines related to computer science, especially software development and automated control. I also gained practical experience in two different areas - APCS engineering, for which opportunity I'm very grateful to my university, and mobile development which I've dived into by my own. As I have tried myself in both fields, I decided to focus on mobile development which seems to me more interesting and innovative. Hopefully, this test project could explain my potential growth as iOS developer. You can contact me via e-mail: kuningram@gmail.com or telegram: tyjo3", comment: "Bio")
        return label
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProfileViewController {

    override func loadView() {
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
