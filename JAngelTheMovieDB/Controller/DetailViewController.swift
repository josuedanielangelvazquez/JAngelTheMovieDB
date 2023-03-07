//
//  DetailViewController.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 07/02/23.
//

import UIKit
import Foundation
class DetailViewController: UIViewController, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource
{
    
    @IBOutlet weak var ButtonAddFavMod: UIButton!
    @IBOutlet weak var postherimage: UIImageView!
    @IBOutlet weak var Titlelbl: UILabel!
    @IBOutlet weak var releaseDatelbl: UILabel!
    @IBOutlet weak var voteAvaragelbl: UILabel!
    @IBOutlet weak var AdultBolllbl: UILabel!
    @IBOutlet weak var originallenguagelbl: UILabel!
    @IBOutlet weak var overviewlbl: UILabel!
    
    @IBOutlet  var collectionView: UICollectionView!
    var segues = ""
    var IdDetail = 0
    var tipo = ""
    let movieViewModel = MovieViewModel()
    let ontvviewmodel = OnTVViewModel()
    var productionCompanies = [ProductionCompanies]()
    
    
    override func viewDidLoad() {
        postherimage.layer.cornerRadius = 20
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        self.collectionView.register(UINib(nibName: "CompaniesProduccionCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ProductionCompaniescell")
        
        
        loadData()
        
    }
    
    @IBAction func AddFaoritesmovies(_ sender: Any) {
        let modeladdfavorite = AddFavoriteMovie(media_type: "movie", media_id: IdDetail, favorite: true)
        
      let result = movieViewModel.addfavMovies(Moviemodel: modeladdfavorite) { ObjectMovie in
          DispatchQueue.main.async {
              if ObjectMovie.success == false {
                
               let alert =   UIAlertController(title: "Error", message: "Sucedio un Error, Intentalo mas tarde", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "Ok", style: .default))
                  self.present(alert, animated: true)
              }
              else{
                  let alert =   UIAlertController(title: "Correct", message: "\(self.Titlelbl.text!) se agrego a favoritos", preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: "Ok", style: .default))
                     self.present(alert, animated: true)
              }
          }
         
        }
    }
    
    func loadData(){
        if segues != ""{
            ButtonAddFavMod.isHidden = true
        }
        else {
            ButtonAddFavMod.isHidden = false

        }
        if tipo.elementsEqual("MOVIE"){
            movieViewModel.GetMoviebyId(idMovie: IdDetail) { MovieDetail in
                DispatchQueue.main.async { [self] in
                    DispatchQueue.main.async {
                        let imageurl = "https://image.tmdb.org/t/p/w1280\(MovieDetail.poster_path!)"
                        let url = URL(string: imageurl)
                        if let data = try? Data(contentsOf: url!){
                            self.postherimage.image = UIImage(data: data)
                        }
                    }
                   
                    self.Titlelbl.text = MovieDetail.title
                    self.releaseDatelbl.text = MovieDetail.release_date
                    self.voteAvaragelbl.text = String(MovieDetail.vote_average)
                    if MovieDetail.adult == false{
                        self.AdultBolllbl.text = "Mayor de 18 años"}
                    else {
                        self.AdultBolllbl.text = "Para toda la familia"
                    }
                    self.originallenguagelbl.text = "Lenguaje: \(MovieDetail.original_language)"
                    self.overviewlbl.text = MovieDetail.overview
                
                    self.productionCompanies = MovieDetail.production_companies as! [ProductionCompanies]
                    collectionView.reloadData()
                    print(MovieDetail.id)
                    
                }}
            
        }
        else{
            ButtonAddFavMod.isHidden = true
            ontvviewmodel.getOnTvById(IdOntV: IdDetail) { OnTVDetail in
                DispatchQueue.main.async {
                    self.Titlelbl.text = OnTVDetail.name
                    self.releaseDatelbl.text = OnTVDetail.first_air_date
                    self.voteAvaragelbl.text = String(OnTVDetail.vote_average!)
                    self.AdultBolllbl.text = "No. episodios:  \(OnTVDetail.number_of_episodes)"
                    self.originallenguagelbl.text = "No. temporadas: \(OnTVDetail.number_of_seasons)"
                    self.overviewlbl.text = OnTVDetail.overview
                    var imageurl = "https://image.tmdb.org/t/p/w1280\(OnTVDetail.poster_path!)"
                    var url = URL(string: imageurl)
                    if let data = try? Data(contentsOf: url!){
                        self.postherimage.image = UIImage(data: data)
                    }
                    self.productionCompanies = OnTVDetail.production_companies as! [ProductionCompanies]
                    self.collectionView.reloadData()
                    
                    
                }
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productionCompanies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductionCompaniescell", for: indexPath as IndexPath) as! CompaniesProduccionCollectionViewCell
        cell.layer.cornerRadius = 10
        var link = productionCompanies[indexPath.row].logo_path
        var imageurl2 = "https://www.asimetrica.org/wp-content/uploads/2019/03/no-imagen.jpg"
        var url = URL(string: "")
        if link != nil{
            var imageurl = "https://image.tmdb.org/t/p/w1280\(link!)"
             url = URL(string: imageurl)!}
        
        else{
             url = URL(string: imageurl2)
        }
         
        if let data = try? Data(contentsOf: url!){

            cell.LogoCompaniesimage.image = UIImage(data: data)
            cell.namelbl.text = productionCompanies[indexPath.row].name

        }
        
    return cell}}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


