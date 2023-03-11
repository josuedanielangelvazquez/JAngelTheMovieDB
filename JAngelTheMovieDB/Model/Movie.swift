//
//  Movie.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 30/01/23.
//

import Foundation
struct Movies: Codable{
    let results : [Movie]?
}
struct Movie: Codable{
    var id: Int
    var poster_path: String?
    var release_date : String
    var title : String
    var vote_average : Double
    var overview : String
}
struct MovieDetail: Codable{
    let id: Int
    let poster_path: String?
    let release_date : String
    let title : String
    let vote_average : Double
    let overview : String
    let adult: Bool
    let original_language: String
    let production_companies: [ProductionCompanies]
}
struct ProductionCompanies: Codable{
    let id: Int
    let logo_path: String?
    let name :String
}
struct AddFavoriteMovie : Codable{
      let media_type: String
      let media_id: Int
      let favorite: Bool
}

struct MovieFavoriteVal: Codable{
    
        let success: Bool
        let status_code: Int
        let status_message : String
    }

struct Videos: Codable{
    let results : [results]
}

struct results : Codable{
    let key: String
}
