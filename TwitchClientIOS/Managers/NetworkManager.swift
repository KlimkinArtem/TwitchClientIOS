//
//  NetworkManager.swift
//  TwitchClientIOS
//
//  Created by Артем Климкин on 19/01/2020.
//  Copyright © 2020 Artem Klimkin. All rights reserved.
//

//curl -H 'Client-ID: 1we71oc0so0wr4ouztap8jw6z6w3ey'
//-X GET 'https://api.twitch.tv/helix/streams?game_id=21779&first=100&language=ru'
//-X GET 'https://api.twitch.tv/helix/users?id=44322889'
//"https://api.twitch.tv/helix/streams?game_id=\(gameId)&first=100&language=ru"

import Foundation

class NetworkManager{
    static let shared = NetworkManager()
    private let clientID = "1we71oc0so0wr4ouztap8jw6z6w3ey"
    

    func getGames(completed: @escaping(Result<GamesData, ErrorMessage>) -> Void){

        guard let url = URL(string: "https://api.twitch.tv/helix/games/top?first=100") else {
            completed(.failure(.unableToComplete))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(clientID, forHTTPHeaderField: "Client-ID")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decode = JSONDecoder()
                decode.keyDecodingStrategy = .convertFromSnakeCase
                let games = try decode.decode(GamesData.self, from: data)
                completed(.success(games))
            }catch let error{
                completed(.failure(.invalidData))
                print(error)
            }
        }.resume()
        
    }
    
    func getStreams(id: String, completed: @escaping(Result<StreamsData, ErrorMessage>) -> Void){
        guard let url = URL(string: "https://api.twitch.tv/helix/streams?game_id=\(id)&first=100&language=ru") else{
            completed(.failure(.unableToComplete))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(clientID, forHTTPHeaderField: "Client-ID")
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decode = JSONDecoder()
                decode.keyDecodingStrategy = .convertFromSnakeCase
                let streamers = try decode.decode(StreamsData.self, from: data)
                completed(.success(streamers))
            }catch let error{
                completed(.failure(.invalidData))
                print(error)
            }
        }.resume()
    }
    
    
    func getUser(id: String, completed: @escaping(Result<UserData, ErrorMessage>) -> Void){
        guard let url = URL(string: "https://api.twitch.tv/helix/users?id=\(id)") else{
            completed(.failure(.unableToComplete))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(clientID, forHTTPHeaderField: "Client-ID")
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decode = JSONDecoder()
                decode.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decode.decode(UserData.self, from: data)
                completed(.success(user))
            }catch let error{
                completed(.failure(.invalidData))
                print(error)
            }
        }.resume()
    }
}
