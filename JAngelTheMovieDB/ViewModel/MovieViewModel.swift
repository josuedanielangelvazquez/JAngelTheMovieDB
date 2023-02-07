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
            return movies
        }
        catch let error{
            print("Error en el decoder\(error.localizedDescription)")
            return nil
        }
    }
    func GetTopRated(TopRated : @escaping (Movies)->Void){
        let moviemodel : Movie? = nil
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=9a12fe4896e3bf5b77905c0eefa45759&language=en-US&page=1")
        urlSession.dataTask(with: url!){
            data, response, error in
            if let safeData = data{
                let json = self.parseJSON(data: safeData)
                TopRated(json!)
                
            }
            else{
                (print(error?.localizedDescription))
            }
        }.resume()
    }
    func GetMoviebyId(idMovie : Int, DetailMovie : @escaping(MovieDetail)->Void){
        let moviedetail : MovieDetail? = nil
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(idMovie)?api_key=9a12fe4896e3bf5b77905c0eefa45759&language=en-US")
        do{
            try urlSession.dataTask(with: url!){
                data, response, error in
                if let  safeData = data{
                    let json  = self.parseJSONDetail(data: safeData)
                    DetailMovie(json!)
                }
                else{
                    print("ERROR EN EL PARSEO \(error?.localizedDescription)")
                }
            }.resume()}
        catch let error{
            print("Error2 \(error.localizedDescription)")
        }
        
    }
    func parseJSONDetail(data : Data)-> MovieDetail?{
        let decodable = JSONDecoder()
        do{
            let requestToken =  try decodable.decode(MovieDetail.self, from: data)
            let moviesDetail = MovieDetail(id: requestToken.id, poster_path: requestToken.poster_path, release_date: requestToken.release_date, title: requestToken.title, vote_average: requestToken.vote_average, overview: requestToken.overview, adult: requestToken.adult, original_language: requestToken.original_language, production_companies: requestToken.production_companies)
            return moviesDetail
        }
        catch let error{
            print("Error en el decoder\(error.localizedDescription)")
            return nil
        }
    }
   
}

   
    

