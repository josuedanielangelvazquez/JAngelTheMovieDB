//
//  OnTVViewModel.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 03/02/23.
//

import Foundation
class OnTVViewModel{
    func GetOnTV(OnTv: @escaping (TVS)-> Void){
        let ontvs : OnTV? = nil
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/tv/on_the_air?api_key=9a12fe4896e3bf5b77905c0eefa45759&language=en-US&page=1")
        urlSession.dataTask(with: url!){ data, reponse, error in
            
            if let safeData = data{
                let json = self.parseJSONTV(data: safeData)
                OnTv(json!)
            }
            else{
                print(error?.localizedDescription)
            }
        }.resume()
    }
    func parseJSONTV(data: Data)-> TVS?{
        let decodable = JSONDecoder()
        do{
            let request = try decodable.decode(TVS.self, from: data )
            let tvs = TVS(results: request.results)
            return tvs
        }
        catch let error{
            print("Error en el decoder\(error.localizedDescription)")
            return nil
        }
    }
    
    func GetAiringToday(TVAiringToday : @escaping (TVS) -> Void){
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/tv/airing_today?api_key=9a12fe4896e3bf5b77905c0eefa45759&language=en-US&page=1")
        urlSession.dataTask(with: url!){
            data, response, error in
            
            if let safeData = data{
                let json = self.parseJSONTV(data: safeData)
                TVAiringToday(json!)
            }
            else{
                print(error?.localizedDescription)
            }
        }.resume()
    }
    func getOnTvById(IdOntV : Int, DetailTV: @escaping (OnTVDetail)->Void){
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/tv/\(IdOntV)?api_key=9a12fe4896e3bf5b77905c0eefa45759&language=en-US")
        urlSession.dataTask(with: url!){
            data, response, error in
            if let safeData = data{
                let json = self.parseJSONTVDetail(data: safeData)
                DetailTV(json!)
            }
            else{
                print(error?.localizedDescription)
            }
        }.resume()
    }
    func parseJSONTVDetail(data : Data)->OnTVDetail?{
        let decodable = JSONDecoder()
        do{
            let requestToken =  try decodable.decode(OnTVDetail.self, from: data)
            let ontvdetail = OnTVDetail(id: requestToken.id, poster_path: requestToken.poster_path, first_air_date: requestToken.first_air_date, name: requestToken.name, vote_average: requestToken.vote_average, overview: requestToken.overview, number_of_episodes: requestToken.number_of_episodes, number_of_seasons: requestToken.number_of_seasons, production_companies: requestToken.production_companies)
            return ontvdetail
        }
        catch let error{
            print("Error en el decoder\(error.localizedDescription)")
            return nil
        }
    }
}

