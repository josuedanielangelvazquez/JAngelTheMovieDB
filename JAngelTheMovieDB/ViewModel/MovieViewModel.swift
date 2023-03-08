//
//  MovieViewModel.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 30/01/23.
//

import Foundation
import CoreData
import UIKit
class MovieViewModel{
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    

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
    func parseJsonFavoriteVal(data: Data)-> MovieFavoriteVal?{
        let decodable = JSONDecoder()
        do{
            let requestToken = try decodable.decode(MovieFavoriteVal.self, from: data)
            let ModelMovieFavorite =  MovieFavoriteVal(success: requestToken.success, status_code: requestToken.status_code, status_message: requestToken.status_message)
          print(ModelMovieFavorite)
            return ModelMovieFavorite
        }
        catch let error{
            print("Error en el decoder\(error.localizedDescription)")
            return nil
        }
    }
    func GetFavoritesMovies(idsession : String, FavoritesMovies : @escaping(Movies)->Void){
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/account/0/favorite/movies?language=en-US&sort_by=created_at.asc&api_key=9a12fe4896e3bf5b77905c0eefa45759&session_id=48dbaafbc657d1cca8dae0f63614acefbae2d362")
     /*   let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=9a12fe4896e3bf5b77905c0eefa45759&language=en-US&page=1")*/
        urlSession.dataTask(with: url!){
            data, response, error in
            if let safeData = data {
                let json = self.parseJSON(data: safeData)
                FavoritesMovies(json!)
            }
            else{print(error?.localizedDescription)}
        }.resume()
    }
    
    func PersistenceAddFavMovies(Movie : Movie)->Bool{
        do{
            let context = appdelegate.persistentContainer.viewContext
            let entidad = NSEntityDescription.entity(forEntityName: "PersistenceMovies", in: context)
            let MovieCoreData = NSManagedObject(entity: entidad!, insertInto: context)
            MovieCoreData.setValue(Movie.id, forKey: "idmovie")
            MovieCoreData.setValue(Movie.title, forKey: "title")
            MovieCoreData.setValue(Movie.overview, forKey: "overview")
            MovieCoreData.setValue(Movie.poster_path, forKey: "postherPath")
            MovieCoreData.setValue(Movie.release_date, forKey: "releaseDate")
            MovieCoreData.setValue(Movie.vote_average, forKey: "vote_average")
            try!context.save()
            return true
        }
        catch let error{
            print(error.localizedDescription)
            return false
        }
    }
    
    func PersistenceGetFavorites()->Bool{
        let context = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PersistenceMovies")
        
        do{
            let movies = [Movies]()
            let moviess = try context.fetch(request)
            for objetosmovies in  movies as! [NSManagedObject]{
                let MovieiD = objetosmovies.value(forKey: "idmovie")
                let Title = objetosmovies.value(forKey: "title")
                let overview = objetosmovies.value(forKey: "overview")
                let postherPath = objetosmovies.value(forKey: "postherPath")
                let releaseDate = objetosmovies.value(forKey: "releaseDate")
                let vote_average = objetosmovies.value(forKey: "vote_average")
                
                var Movie = try! Movie(id: MovieiD as! Int, release_date: releaseDate as! String, title: Title as! String, vote_average: vote_average as! Double, overview: overview as! String)
                
                
            }
        }
        catch let error{
            print(error.localizedDescription)
            return false
        }
        
        
        
        
        return true
    }
    
    func addfavMovies(Moviemodel : AddFavoriteMovie, ValMovieFav : @escaping(MovieFavoriteVal)->Void){
        DispatchQueue.main.async {
            let decoder = JSONDecoder()
            let URLbase = "https://api.themoviedb.org/3/account/0/favorite?api_key=9a12fe4896e3bf5b77905c0eefa45759&session_id=dc649728590d5c88a0dadaa49da999a6cd9c44a9"
            let url = URL(string: URLbase)!
            var urlrequest = URLRequest(url: url)
            urlrequest.httpMethod = "POST"
            urlrequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlrequest.httpBody = try! JSONEncoder().encode(Moviemodel)
            let urlsession = URLSession.shared
            urlsession.dataTask(with: urlrequest){data, response, error in
                if let safedata = data{
                    let json = self.parseJsonFavoriteVal(data: safedata)
                    ValMovieFav(json!)
                }
            }.resume()
       
        }
        
        
    }
   
}

   
    

