//
//  Button.swift
//  TwitchClientIOS
//
//  Created by Артем Климкин on 27/01/2020.
//  Copyright © 2020 Artem Klimkin. All rights reserved.
//

import UIKit

class Button: UIButton {


    init(title: String, color: UIColor){
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        backgroundColor = color
        
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
}
