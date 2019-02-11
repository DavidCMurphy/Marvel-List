//
//  CharacterDetailController.swift
//  MarvelList
//
//  Created by David Murphy on 07/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import UIKit
import SafariServices

private let DetailImageHeight: CGFloat = UIScreen.main.bounds.height / 2

class CharacterDetailController: UIViewController {
    
    let imageView = UIImageView()
    let descriptionLabel = UILabel()
    let scrollView = UIScrollView()
    let url: URL?
    let urlButton = UIButton()
    
    init<T: DetailModelProtocol>( _ model: T ) {
        url = model.url
        super.init(nibName: nil, bundle: nil)
        
        title = model.name
        imageView.setRemoteImageWithAnimation(url: model.image_url)
        descriptionLabel.text = model.description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.FlatColor.Gray.WhiteSmoke
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        descriptionLabel.numberOfLines = 0
        
        urlButton.isHidden = ( url == nil )
        urlButton.layer.cornerRadius = 5
        urlButton.layer.masksToBounds = true
        urlButton.backgroundColor = UIColor.FlatColor.Blue.Mariner
        urlButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        urlButton.setTitle("DETAILS", for: .normal)
        urlButton.addTarget(self, action: #selector(openSite), for: .touchUpInside)
        
        scrollView.showsVerticalScrollIndicator = false
        
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(scrollView)
        scrollView.addSubview(descriptionLabel)
        view.addSubview(urlButton)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: DetailImageHeight).isActive = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: urlButton.topAnchor ).isActive = true
        
        urlButton.translatesAutoresizingMaskIntoConstraints = false
        urlButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        urlButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        urlButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        urlButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc func openSite() {
        openSafari( url )
    }
}
