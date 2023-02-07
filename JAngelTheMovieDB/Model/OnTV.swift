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

struct OnTVDetail: Codable{
    let id: Int
    let poster_path: String?
    let first_air_date: String?
    let name: String?
    let vote_average: Double?
    let overview : String
    let number_of_episodes: Int
    let number_of_seasons: Int
    let production_companies: [ProductionCompanies]

}

