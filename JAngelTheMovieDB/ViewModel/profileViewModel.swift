//
//  profileViewModel.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 08/02/23.
//

import Foundation
class profileViewModel{
    func GetInfoprofile(userdetailcount : @escaping(UserDetailsCount)->Void){
        let defaults = UserDefaults.standard
        let idsession = defaults.string(forKey: "idsession")
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/account?api_key=9a12fe4896e3bf5b77905c0eefa45759&session_id=\(idsession!)")!
        print(url)
        urlSession.dataTask(with: url){
            data, response, error in
            if let safeData = data{
                let json = self.parseJSON(data: safeData)
                userdetailcount(json!)
            }
        }.resume()
    }
    func parseJSON(data: Data)->UserDetailsCount?{
        let decodable = JSONDecoder()
        do{
            let requestToken = try decodable.decode(UserDetailsCount.self, from: data)
            let usuarioprofile = UserDetailsCount(id: requestToken.id, username: requestToken.username)
            return usuarioprofile
        }
        catch let error{
            print("Error en el decoder\(error.localizedDescription)")
            return nil
        }
        
    }
}
