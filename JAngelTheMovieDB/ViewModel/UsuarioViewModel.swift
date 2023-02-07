//
//  UsuarioViewModel.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 31/01/23.
//

import Foundation
class UsuarioViewModel{
    var usuarioModel: Usuario? = nil
    let defaults = UserDefaults.standard
    func RequestToken(Tokenrequest : @escaping (String)->Void){
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/authentication/token/new?api_key=9a12fe4896e3bf5b77905c0eefa45759")
        urlSession.dataTask(with: url!){ data, response, error in
            
            if let safeData = data{
                let json = self.parseJSON(data: safeData)
                Tokenrequest(json!.request_token!)
            }
            else{print(error?.localizedDescription)}
        }.resume()
       
    }
    func parseJSON(data : Data)-> Usuario?{
        let decodable = JSONDecoder()
        do{
            let requestToken = try decodable.decode(Usuario.self, from: data)
            let usuario = Usuario(success: requestToken.success, expires_at: requestToken.expires_at, request_token: requestToken.request_token)
            return usuario
        }
        catch let error{
            print("Error en el decoder \(error.localizedDescription)")
            return nil
        }
    }
    func Loguin(usuario: UsuarioLogin, VALIDACION: @escaping (Bool)->Void){
        let decoder = JSONDecoder()
        let BASEURL = "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=9a12fe4896e3bf5b77905c0eefa45759"
        let url = URL(string: BASEURL)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try! JSONEncoder().encode(usuario)
        let urlSession = URLSession.shared
        urlSession.dataTask(with: urlRequest){
            data, respone, error in
            if let safedata = data{
                let json = self.parseJSON(data: safedata)
                VALIDACION(json!.success)
            }
            
        
        }.resume()
        
    }
}
