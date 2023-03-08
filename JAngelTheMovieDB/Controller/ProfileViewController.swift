//
//  ProfileViewController.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 03/02/23.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var CollectionView: UICollectionView!
    var movieviewmodel = MovieViewModel()
    var profileviewmodel = profileViewModel()
    var movie = [Movie]()
    var countmovie = 0
    var idMovieTv = 0
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.delegate = self
        CollectionView.dataSource = self
        view.addSubview(CollectionView)
        self.CollectionView.register(UINib(nibName: "PeliculasCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "Moviecell")
        loadDataprofile()
        
        loadData()
        // Do any additional setup after loading the view.
    }
    func loadData(){
        let idsession = defaults.string(forKey: "idsession")

        print(idsession)
        movieviewmodel.GetFavoritesMovies(idsession: idsession!) { moviefavorites in
            DispatchQueue.main.async {
                self.movie = moviefavorites.results as! [Movie]
                self.CollectionView.reloadData()
                self.countmovie = self.movie.count
                
            }
        }
    }
    func loadDataprofile(){
        profileviewmodel.GetInfoprofile { infoprofile in
            DispatchQueue.main.async {
                self.username.text = "@\(infoprofile.username)"
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countmovie
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Moviecell", for: indexPath as IndexPath) as! PeliculasCollectionViewCell
        cell.id = movie[indexPath.row].id
        cell.Titlelbl.text = movie[indexPath.row].title
        cell.Popularitylbl.text = String(movie[indexPath.row].vote_average)
        cell.Fecha_lanzamientolbl.text = movie[indexPath.row].release_date
        cell.overview.text = movie[indexPath.row].overview
        cell.layer.cornerRadius = 10
        cell.buttonfav.isHidden = true
        cell.loaddata.isHidden = true
        cell.loaddata.stopAnimating()
        var imageurl = "https://image.tmdb.org/t/p/w1280\(self.movie[indexPath.row].poster_path!)"
                  var url = URL(string: imageurl)
                  if let data = try? Data(contentsOf: url!){
                      DispatchQueue.main.async {
          
                          cell.MovieiMAGE.image = UIImage(data: data)
                          
                      }
        }
        
     
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
            self.idMovieTv = movie[indexPath.row].id
            performSegue(withIdentifier: "seguesDetailFav", sender: nil)
            print(self.idMovieTv)
     
   }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "seguesDetailFav"{
           let detail = segue.destination as! DetailViewController
           detail.IdDetail = self.idMovieTv
           detail.tipo = "MOVIE"
           detail.segues = "fav"
       }
   }
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
