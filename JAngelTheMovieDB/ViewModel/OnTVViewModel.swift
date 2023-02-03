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
}

