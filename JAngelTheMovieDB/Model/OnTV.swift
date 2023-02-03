//
//  OnTV.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 03/02/23.
//

import Foundation
struct TVS: Codable{
    let results : [OnTV]?
}
struct OnTV: Codable{
    var id: Int
    var poster_path: String?
    var first_air_date: String?
    var name: String?
    var vote_average: Double?
    var overview : String
}

