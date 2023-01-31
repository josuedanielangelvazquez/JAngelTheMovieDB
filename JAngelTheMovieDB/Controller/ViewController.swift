//
//  ViewController.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 30/01/23.
//

import UIKit

class ViewController: UIViewController {
    var movie = MovieViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func EntrarAction(_ sender: UIButton) {
    
           movie.RequestToken()
    }
    

}

