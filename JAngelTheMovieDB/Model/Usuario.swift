//
//  Usuario.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 30/01/23.
//

import Foundation

struct Usuario : Codable{
    let success : Bool
    let expires_at : String?
    let request_token : String?
    
  /*  enum UsuarioKeys: String, CodingKey{
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }*/
}

struct UsuarioLogin : Codable{
    let username : String
    let password : String
    var request_token : String
}
struct UsuarioIdLoguin: Codable{
    var request_token : String
}
 
struct UsuarioLoguinrequest: Codable{
    var session_id : String
}
struct UserDetailsCount: Codable{
    var id: Int
    var username : String
    
}
struct UsuarioDeleteSession: Codable{
    var session_id: String
}
struct UsuarioDeleteSessionval: Codable{
    var success: Bool
}
