//
//  MovieViewModel.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 30/01/23.
//

import Foundation

class MovieViewModel{
    var usuarioModel: Usuario? = nil
    func RequestToken(){
        
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/authentication/token/new?api_key=9a12fe4896e3bf5b77905c0eefa45759")
        urlSession.dataTask(with: url!){ data, response, error in
          
            if let safeData = data{
                let json = self.parseJSON(data: safeData)
             
            }
        }.resume()
      }
    func parseJSON(data : Data)-> Usuario?{
        let decodable = JSONDecoder()
        do{
            let requestToken = try decodable.decode(Usuario.self, from: data)
            let usuario = Usuario(success: requestToken.success, expires_at: requestToken.expires_at, request_token: requestToken.request_token)
            print(usuario.expires_at)
            print(usuario.success)
            print(usuario.request_token)
            return usuario
        }
        catch let error{
            print("Error en el decoder \(error.localizedDescription)")
            return nil
        }
    }
    func 
        
    }
    

