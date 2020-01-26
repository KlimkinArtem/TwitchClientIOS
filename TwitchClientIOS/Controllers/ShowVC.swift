//
//  ShowVC.swift
//  TwitchClientIOS
//
//  Created by Артем Климкин on 26/01/2020.
//  Copyright © 2020 Artem Klimkin. All rights reserved.
//

import UIKit
import WebKit

class ShowVC: UIViewController {

    var webView: WKWebView!
    
    var userID: String!
    var username: String!
    var streamURL: URL!
    var streamTitle: String!
    var userImageURL: String!
    var userImage = ImageView(frame: .zero)
    var border = ImageView(frame: .zero)
    var titleLabel = Label(textAligment: .left, fontSize: 12)
    var subscribeButton = Button(title: "Подписаться", color: .systemGreen)
    var unsubscribeButton = Button(title: "Отписаться", color: .systemRed)
    
    init(id: String, name: String, streamURL: URL, title: String){
        super.init(nibName: nil, bundle: nil)
        userID = id
        self.streamURL = streamURL
        streamTitle = title
        username = name
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureWebView(url: streamURL)
        getUser(id: userID)
        
    }
    
    
    func configureWebView(url: URL){
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 480)
        webView = WKWebView(frame: frame, configuration: WKWebViewConfiguration())
        let request = URLRequest(url: url)
        webView.load(request)
        view.addSubview(webView)
    }
    
    func configureCustomCell(userImageURL: String){
        
        view.addSubview(border)
        view.addSubview(userImage)
        view.addSubview(titleLabel)
        view.addSubview(subscribeButton)
        view.addSubview(unsubscribeButton)
        
                
        border.image = UIImage(named: "border1")
        border.alpha = 0.5
        
        guard let url = URL(string: userImageURL) else{
            return
        }
        
        if let data = try? Data(contentsOf: url){
            userImage.image = UIImage(data: data)
        }
        
        titleLabel.text = streamTitle
        
        subscribeButton.addTarget(self, action: #selector(subscribe), for: .touchUpInside)
        
        unsubscribeButton.isHidden = true
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 12),
            userImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            userImage.heightAnchor.constraint(equalToConstant: 80),
            userImage.widthAnchor.constraint(equalToConstant: 80),
            
            border.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 5),
            border.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            border.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            border.bottomAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 7),
            
            titleLabel.topAnchor.constraint(equalTo: userImage.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: border.trailingAnchor, constant: -10),
            
            subscribeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subscribeButton.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            subscribeButton.trailingAnchor.constraint(equalTo: border.trailingAnchor, constant: -10),
            subscribeButton.bottomAnchor.constraint(equalTo: userImage.bottomAnchor),

            unsubscribeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            unsubscribeButton.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            unsubscribeButton.trailingAnchor.constraint(equalTo: border.trailingAnchor, constant: -10),
            unsubscribeButton.bottomAnchor.constraint(equalTo: userImage.bottomAnchor)
        ])
        
        
    }
    
    @objc func subscribe(){
        print(#function)
        subscribeButton.isHidden = true
        unsubscribeButton.isHidden = false
        
        unsubscribeButton.addTarget(self, action: #selector(unsubscribe), for: .touchUpInside)
    }
    
    @objc func unsubscribe(){
        print(#function)
        
        subscribeButton.isHidden = false
        unsubscribeButton.isHidden = true
    }
    


    func getUser(id: String){
        NetworkManager.shared.getUser(id: id) { (user) in
            DispatchQueue.main.async {
                self.configureCustomCell(userImageURL: user.data[0].profileImageUrl)
            }
        }
    }
}
