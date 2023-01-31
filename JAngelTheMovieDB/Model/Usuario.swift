//
//  Usuario.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 30/01/23.
//

import Foundation

struct Usuario : Codable{
    let success : Bool?
    let expires_at : String?
    let request_token : String?
    
  /*  enum UsuarioKeys: String, CodingKey{
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }*/
}
