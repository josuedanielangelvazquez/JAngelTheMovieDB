//
//  MovieViewModel.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 30/01/23.
//

import Foundation

class MovieViewModel{
    
    func getPopular(Movie : @escaping (Movies)->Void){
        let moviemodel : Movie? = nil
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=9a12fe4896e3bf5b77905c0eefa45759&language=en-US&page=1")
        urlSession.dataTask(with: url!){ data, response, error in
            
            if let safeData = data{
                let json = self.parseJSON(data: safeData)
                Movie(json!)
            }
            else{print(error?.localizedDescription)}
        }.resume()
      
    }
    func parseJSON(data: Data)-> Movies?{
        let decodable = JSONDecoder()
        do{
            let request =  try decodable.decode(Movies.self, from: data)
            let movies = Movies(results: request.results)
            print(movies.results)
            return movies
        }
        catch let error{
            print("Error en el decoder\(error.localizedDescription)")
                return nil
        }
    }
 }

   
    

