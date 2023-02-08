//
//  ViewController.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 30/01/23.
//

import UIKit

class ViewController: UIViewController {
    var usuarioidloguin : UsuarioIdLoguin? = nil
    var usuariologin : UsuarioLogin? = nil
    let defaults = UserDefaults.standard

    var usuariomodel  = ""
    var labelerror = "ivalid username and/or password: You did not provide  a valid login"
    var userLoguinId = ""
    @IBOutlet weak var Usernamelbl: UITextField!
    @IBOutlet weak var Passwordlbl: UITextField!
    
    @IBOutlet weak var messageerrorlbl: UILabel!
    
    var UsuarioLoguin = UsuarioViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        UsuarioLoguin.RequestToken { token in
            self.usuariomodel = token
            self.usuarioidloguin = UsuarioIdLoguin(request_token: token)
        }
        
    }
    
    
    @IBAction func EntrarAction(_ sender: UIButton) {
        let result = UsuarioLogin(username: Usernamelbl.text!, password: Passwordlbl.text!, request_token: usuariomodel)
        UsuarioLoguin.Loguin(usuario: result) { validacion in
            if validacion == true{
                DispatchQueue.main.async {
                    self.UsuarioLoguin.GetSessionId(usuariologuin: self.usuarioidloguin!){idsession in
                        self.defaults.set(idsession, forKey: "idsession")
                       

                    }
                    self.performSegue(withIdentifier: "seguesmovies", sender: nil)
                    
                }
              
            }
            else{
                DispatchQueue.main.async {
                    self.messageerrorlbl.text = self.labelerror
                    let alert = UIAlertController(title: "Error", message: "Ingresa Credenciales correctas", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "ok", style: .default)
                    alert.addAction(ok)
                    self.present(alert, animated: true)
                }
             
            }
        }
    }
    

}

