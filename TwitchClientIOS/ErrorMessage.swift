//
//  ErrorMessage.swift
//  TwitchClientIOS
//
//  Created by Артем Климкин on 28/01/2020.
//  Copyright © 2020 Artem Klimkin. All rights reserved.
//Ò

import Foundation

enum ErrorMessage: String, Error{
    
    case unableToComplete = "Проблемы с интернет соединением. Пожалуйста, попробуйте еще раз"
    case invalidResponse = "Что-то не так с сервером. Пожалуйста, попробуйте еще раз."
    case invalidData = "Данные, которые получены от сервера оказались некоректными. Пожалуйста, попробуйте еще раз."
}
