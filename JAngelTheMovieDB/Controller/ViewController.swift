//
//  ViewController.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 30/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    var usuariologin : UsuarioLogin? = nil
    var usuariomodel  = ""
    @IBOutlet weak var Usernamelbl: UITextField!
    @IBOutlet weak var Passwordlbl: UITextField!
    
    var UsuarioLoguin = UsuarioViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
  usuariomodel = UsuarioLoguin.RequestToken()
        
    }
    
    
    @IBAction func EntrarAction(_ sender: UIButton) {
        let result = UsuarioLogin(success: Usernamelbl.text!, password: Passwordlbl.text!, request_token: usuariomodel)
        print(usuariomodel)
        UsuarioLoguin.Loguin(var: result)
          
    }
    

}

