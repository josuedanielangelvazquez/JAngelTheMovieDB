//
//  UsuarioViewModel.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 31/01/23.
//

import Foundation
class UsuarioViewModel{
    var usuarioModel: Usuario? = nil
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
    func GetSessionId(usuariologuin : UsuarioIdLoguin, idsession: @escaping (String?)->Void){
        let decoedr = JSONDecoder()
        let baseurl = "https://api.themoviedb.org/3/authentication/session/new?api_key=9a12fe4896e3bf5b77905c0eefa45759"
        let url = URL(string: baseurl)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try! JSONEncoder().encode(usuariologuin)
        //SE OBTIENE RESPUESTA
        let urlSession = URLSession.shared
        urlSession.dataTask(with: urlRequest){
            data, response, error in
            if let safeData = data{
                let json = self.parseJSONsessionid(data: safeData)
                idsession(json!.session_id)
                
            }
        }.resume()
    }
    func parseJSONsessionid(data: Data)-> UsuarioLoguinrequest?{
        let decodable = JSONDecoder()
        do{
            let requesttoken = try decodable.decode(UsuarioLoguinrequest.self
                                                    , from: data)
            let usuarioidsession = UsuarioLoguinrequest(session_id: requesttoken.session_id)
            return usuarioidsession
        }
        catch let error{
            print("Error en el decoder \(error.localizedDescription)")
            return nil
        }
    }
    func parseJSONDeleteSession(data: Data)->UsuarioDeleteSessionval?{
        let decodable = JSONDecoder()
        do{
            let requestval = try decodable.decode(UsuarioDeleteSessionval.self, from: data)
            let deletesessionval = UsuarioDeleteSessionval(success: requestval.success)
            return deletesessionval
        }
        catch let error{
            print("Error en el decoder \(error.localizedDescription)")
            return nil
        }
    }
    
    func DeleteSession(usuariodeletesession : UsuarioDeleteSession, Objectdeletesession: @escaping (Bool)->Void){
        let decoder = JSONDecoder()
        let baseurl = "https://api.themoviedb.org/3/authentication/session?api_key=9a12fe4896e3bf5b77905c0eefa45759"
        let url = URL(string: baseurl)
        var urlrequest = URLRequest(url: url!)
        urlrequest.httpMethod = "DELETE"
        urlrequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlrequest.httpBody = try! JSONEncoder().encode(usuariodeletesession)
        let urlsession = URLSession.shared
        urlsession.dataTask(with: urlrequest){ [self]
            data, error, response in
            if let safedata = data{
                let json = parseJSONDeleteSession(data: safedata)
                Objectdeletesession(json!.success)
            }
        }.resume()
        }
        
    }
    
    

