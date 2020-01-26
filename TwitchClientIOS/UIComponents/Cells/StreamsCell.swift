//
//  StreamsCell.swift
//  TwitchClientIOS
//
//  Created by Артем Климкин on 26/01/2020.
//  Copyright © 2020 Artem Klimkin. All rights reserved.
//

import UIKit

class StreamsCell: UICollectionViewCell {
    
    static let reuseID = "StreamsCell"
    let thumbnailImage = ImageView(frame: .zero)
    let userNameLabel = Label(textAligment: .center, fontSize: 16)
    let gameNameLabel = Label(textAligment: .center, fontSize: 12)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStreamsCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStreamsCell(){
        
        addSubview(thumbnailImage)
        addSubview(userNameLabel)
        addSubview(gameNameLabel)

        
        NSLayoutConstraint.activate([
            thumbnailImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            thumbnailImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            thumbnailImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            thumbnailImage.heightAnchor.constraint(equalToConstant: 300),
            
            userNameLabel.topAnchor.constraint(equalTo: thumbnailImage.bottomAnchor, constant: 12),
            userNameLabel.leadingAnchor.constraint(equalTo: thumbnailImage.leadingAnchor, constant: 8),
            userNameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            
            gameNameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 12),
            gameNameLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor, constant: 0),
            gameNameLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: -8),
            gameNameLabel.heightAnchor.constraint(equalToConstant: 16),
            gameNameLabel.widthAnchor.constraint(equalToConstant: 260)
            
        ])
        

    }
}
