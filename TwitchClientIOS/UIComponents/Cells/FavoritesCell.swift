//
//  FavoritesCell.swift
//  TwitchClientIOS
//
//  Created by Артем Климкин on 01/02/2020.
//  Copyright © 2020 Artem Klimkin. All rights reserved.
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    
    static let reuseID = "FavoritesCell"
    
    let userImage = ImageView(frame: .zero)
    let usernameLabel = Label(textAligment: .center, fontSize: 12)
    
    var containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureContainerView()
        configureGamesCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContainerView(){
        addSubview(containerView)
        
        containerView.backgroundColor = .systemGray5
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    private func configureGamesCell(){
        
        containerView.addSubview(userImage)
        containerView.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            userImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            userImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            userImage.heightAnchor.constraint(equalTo: userImage.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 6),
            usernameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            usernameLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}
