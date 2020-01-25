//
//  NetworkManager.swift
//  TwitchClientIOS
//
//  Created by Артем Климкин on 19/01/2020.
//  Copyright © 2020 Artem Klimkin. All rights reserved.
//

//curl -H 'Client-ID: 1we71oc0so0wr4ouztap8jw6z6w3ey'
//-X GET 'https://api.twitch.tv/helix/games/top'

import Foundation

class NetworkManager{
    static let shared = NetworkManager()
    private let clientID = "1we71oc0so0wr4ouztap8jw6z6w3ey"
    

    func getAllGames(completed: @escaping(GamesData) -> Void){

        guard let url = URL(string: "https://api.twitch.tv/helix/games/top?first=100") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(clientID, forHTTPHeaderField: "Client-ID")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            guard let data = data else{
                return
            }
            
            do{
                let decode = JSONDecoder()
                decode.keyDecodingStrategy = .convertFromSnakeCase
                let games = try decode.decode(GamesData.self, from: data)
                completed(games)
            }catch let error{
                print(error)
            }
        }.resume()
        
    }
}
