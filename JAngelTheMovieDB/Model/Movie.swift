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
    var poster_path: String?
    var release_date : String
    var title : String
    var popularity : Double
    var overview : String
}

