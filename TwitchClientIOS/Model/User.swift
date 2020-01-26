//
//  User.swift
//  TwitchClientIOS
//
//  Created by Артем Климкин on 26/01/2020.
//  Copyright © 2020 Artem Klimkin. All rights reserved.
//

import Foundation

struct UserData: Decodable {
    let data: [User]
}

struct User: Decodable {
    let login: String
    let profileImageUrl: String
    let description: String
}



//{
//  "data": [{
//    "id": "44322889",
//    "login": "dallas",
//    "display_name": "dallas",
//    "type": "staff",
//    "broadcaster_type": "",
//    "description": "Just a gamer playing games and chatting. :)",
//    "profile_image_url": "https://static-cdn.jtvnw.net/jtv_user_pictures/dallas-profile_image-1a2c906ee2c35f12-300x300.png",
//    "offline_image_url": "https://static-cdn.jtvnw.net/jtv_user_pictures/dallas-channel_offline_image-1a2c906ee2c35f12-1920x1080.png",
//    "view_count": 191836881,
//    "email": "login@provider.com"
//  }]
//}
