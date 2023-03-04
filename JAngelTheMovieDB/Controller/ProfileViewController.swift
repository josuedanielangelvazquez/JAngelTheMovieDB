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

     /* let result =  movieviewmodel.getPopular(){ MoviesObjects in
                DispatchQueue.main.async {
                self.movie = MoviesObjects.results as! [Movie]
                self.CollectionView.reloadData()
                    self.countmovie = self.movie.count
            }
        }*/
        
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
        DispatchQueue.main.async {
            var imageurl = "https://image.tmdb.org/t/p/w1280\(self.movie[indexPath.row].poster_path!)"
                      var url = URL(string: imageurl)
                      if let data = try? Data(contentsOf: url!){
                          cell.MovieiMAGE.image = UIImage(data: data)
                          
                      }
        }
        
        cell.id = movie[indexPath.row].id
        cell.Titlelbl.text = movie[indexPath.row].title
        cell.Popularitylbl.text = String(movie[indexPath.row].vote_average)
        cell.Fecha_lanzamientolbl.text = movie[indexPath.row].release_date
        cell.overview.text = movie[indexPath.row].overview
        cell.layer.cornerRadius = 10
        
        return cell
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
