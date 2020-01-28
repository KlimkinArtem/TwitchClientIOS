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
    var chatWebView: WKWebView!
    
    
    var userID: String!
    var username: String!
    var streamURL: URL!
    var streamTitle: String!
    var userImageURL: String!
    
    var webContainerView = UIView()
    var containerView = UIView()
    var userProfileImage = ImageView(frame: .zero)
    var streamTitleLabel = Label(textAligment: .left, fontSize: 12)
    var subscribeButton = Button(title: "Подписаться", color: .systemGreen)
    var unsubscribeButton = Button(title: "Отписаться", color: .systemRed)
    var userProfileButton = Button(frame: .zero)
    
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
        
        
        getUser(id: userID)
        
        
    }
    
    
    @objc func getUserProfile(){
        print(#function)
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
            
            switch user{
            case .success(let user):
                DispatchQueue.main.async {
                    self.userImageURL = user.data[0].profileImageUrl
                    self.invokeConfigure()
                }
            case .failure(let error):
                print(error.rawValue)
            }
            
            
        }
    }
}






extension ShowVC{
    
    func invokeConfigure(){
        configureWebView()
        configureContainerView()
        configureUserImage(userImageURL: userImageURL)
        configureUserProfileButton()
        configureStreamTitle()
        configureSubscribeButton()
        configureUnsubscribeButton()
//        configureWebContainerView()
//        configureChatWebView()
    }
    
    func configureWebView(){
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 480)
        webView = WKWebView(frame: frame, configuration: WKWebViewConfiguration())
        let request = URLRequest(url: streamURL)
        webView.load(request)
        view.addSubview(webView)
    }
    
    func configureContainerView(){
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemGray4
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5 ),
            containerView.heightAnchor.constraint(equalToConstant: 104)
        ])
    }
    
    func configureUserImage(userImageURL: String){
        containerView.addSubview(userProfileImage)
        
        guard let url = URL(string: userImageURL) else{
            return
        }
        
        if let data = try? Data(contentsOf: url){
            userProfileImage.image = UIImage(data: data)
        }
        
        
        NSLayoutConstraint.activate([
            userProfileImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            userProfileImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            userProfileImage.heightAnchor.constraint(equalToConstant: 80),
            userProfileImage.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configureUserProfileButton(){
        view.addSubview(userProfileButton)
        
        userProfileButton.addTarget(self, action: #selector(getUserProfile), for: .touchUpInside)

        NSLayoutConstraint.activate([
            userProfileButton.topAnchor.constraint(equalTo: userProfileImage.topAnchor),
            userProfileButton.leadingAnchor.constraint(equalTo: userProfileImage.leadingAnchor),
            userProfileButton.trailingAnchor.constraint(equalTo: userProfileImage.trailingAnchor),
            userProfileButton.bottomAnchor.constraint(equalTo: userProfileImage.bottomAnchor)
        ])
        
    }
    

    func configureStreamTitle(){
        containerView.addSubview(streamTitleLabel)
        
        streamTitleLabel.text = streamTitle
        
        
        
        NSLayoutConstraint.activate([
            streamTitleLabel.topAnchor.constraint(equalTo: userProfileImage.topAnchor, constant: -20),
            streamTitleLabel.leadingAnchor.constraint(equalTo: userProfileImage.trailingAnchor, constant: 10),
            streamTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
    }
    
    func configureSubscribeButton(){
        containerView.addSubview(subscribeButton)
        
        subscribeButton.addTarget(self, action: #selector(subscribe), for: .touchUpInside)
        
        unsubscribeButton.isHidden = true
        
        NSLayoutConstraint.activate([
            subscribeButton.topAnchor.constraint(equalTo: streamTitleLabel.bottomAnchor, constant: 10),
            subscribeButton.leadingAnchor.constraint(equalTo: userProfileImage.trailingAnchor, constant: 10),
            subscribeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            subscribeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
        ])
    }
    
    func configureUnsubscribeButton(){
        containerView.addSubview(unsubscribeButton)
        
        unsubscribeButton.addTarget(self, action: #selector(unsubscribe), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            unsubscribeButton.topAnchor.constraint(equalTo: streamTitleLabel.bottomAnchor, constant: 10),
            unsubscribeButton.leadingAnchor.constraint(equalTo: userProfileImage.trailingAnchor, constant: 10),
            unsubscribeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            unsubscribeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
        ])
    }
    
    
    func configureWebContainerView(){
        view.addSubview(webContainerView)
        
        webContainerView.backgroundColor = .systemBackground
        webContainerView.layer.cornerRadius = 10
        webContainerView.layer.borderWidth = 2
        webContainerView.layer.borderColor = UIColor.white.cgColor
        webContainerView.translatesAutoresizingMaskIntoConstraints = false
        

        NSLayoutConstraint.activate([
            webContainerView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 5),
            webContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            webContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            webContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        ])
    }
    
    
    
    func configureChatWebView(){
        guard let url = URL(string: "https://www.twitch.tv/embed/\(username!)/chat") else {
            return
        }
        
        let frame = CGRect(x: 0, y: 0, width: webContainerView.bounds.width, height: webContainerView.bounds.height)
        chatWebView = WKWebView(frame: frame, configuration: WKWebViewConfiguration())
        let request = URLRequest(url: url)
        chatWebView.load(request)
        webContainerView.addSubview(chatWebView)
    }
    
}
