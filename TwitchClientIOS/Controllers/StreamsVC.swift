//
//  StreamersVC.swift
//  TwitchClientIOS
//
//  Created by Артем Климкин on 26/01/2020.
//  Copyright © 2020 Artem Klimkin. All rights reserved.
//

import UIKit

class StreamsVC: UIViewController {

    var gameID: String!
    var gameName: String!
    var collectionView: UICollectionView!
    
    var userNameArray: [String] = []
    var thumbnailArray: [String] = []
    var viewerCountArray: [Int] = []
    
    var userIDArray: [String] = []
    var streamTitleArray: [String] = []
    
    
    init(id: String, name: String){
        super.init(nibName: nil, bundle: nil)
        gameID = id
        gameName = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        configureCollectionView()
        getStreams()
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.register(StreamsCell.self, forCellWithReuseIdentifier: StreamsCell.reuseID)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout{
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let avalibleWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWigth = avalibleWidth
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWigth, height: itemWigth)
        
        return layout
    }
    
    func getStreams(){
        
        NetworkManager.shared.getStreams(id: gameID) { (streamers) in
            for item in 0 ..< streamers.data.count{
                self.userNameArray.append(streamers.data[item].userName)
                self.thumbnailArray.append(streamers.data[item].thumbnailUrl)
                self.viewerCountArray.append(streamers.data[item].viewerCount)
                
                self.userIDArray.append(streamers.data[item].userId)
                self.streamTitleArray.append(streamers.data[item].title)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    
    }

    func correctUrl(url: String) -> String{
        let oldUrl = url.replacingOccurrences(of: "{width}", with: "300")
        let newUrl = oldUrl.replacingOccurrences(of: "{height}", with: "300")
        
        return newUrl
    }
}

extension StreamsVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StreamsCell.reuseID, for: indexPath) as! StreamsCell
        
        let thumbnailURL = URL(string: correctUrl(url: thumbnailArray[indexPath.row]))!
        
        if let data = try? Data(contentsOf: thumbnailURL){
            cell.thumbnailImage.image = UIImage(data: data)
        }

        cell.userNameLabel.text = "\(userNameArray[indexPath.row]) | Viewrs: \(viewerCountArray[indexPath.row])"
        cell.gameNameLabel.text = gameName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item != -1{
            guard let streamURL = URL(string: "https://player.twitch.tv/?channel=\(userNameArray[indexPath.row])") else{
                return
            }
            let showVC = ShowVC(id: userIDArray[indexPath.row],
                                name: userNameArray[indexPath.row],
                                streamURL: streamURL,
                                title: streamTitleArray[indexPath.row])
            showVC.title = userNameArray[indexPath.row]
            navigationController?.pushViewController(showVC, animated: true)
        }
    }
    
}