//
//  File.swift
//  MarvelList
//
//  Created by David Murphy on 07/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import UIKit

public let ListImageHeight: CGFloat = UIScreen.main.bounds.height / 4

class CharacterCell: UITableViewCell {
    
     let characterImageView = UIImageView()
     let characterName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.clipsToBounds = true
        characterImageView.layer.cornerRadius = 5
        characterImageView.layer.masksToBounds = true
        contentView.addSubview(characterImageView)
        contentView.addSubview(characterName)
        
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.heightAnchor.constraint(equalToConstant: ListImageHeight).isActive = true
        characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        characterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        characterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        characterImageView.bottomAnchor.constraint(equalTo: characterName.topAnchor, constant: -10).isActive = true
        
        characterName.translatesAutoresizingMaskIntoConstraints = false
        characterName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        characterName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
