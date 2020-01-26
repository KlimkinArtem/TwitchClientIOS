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
        
    }
    
    
    func configureWebView(url: URL){
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 480)
        webView = WKWebView(frame: frame, configuration: WKWebViewConfiguration())
        let request = URLRequest(url: url)
        webView.load(request)
        view.addSubview(webView)
    }
    
    
}
