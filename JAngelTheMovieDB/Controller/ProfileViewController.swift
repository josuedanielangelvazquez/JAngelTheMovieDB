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
      let result =  movieviewmodel.getPopular { MoviesObjects in
                DispatchQueue.main.async {
                self.movie = MoviesObjects.results as! [Movie]
                self.CollectionView.reloadData()
                    self.countmovie = self.movie.count
            }
        }
        /*  movieviewmodel.GetFavoritesMovies { moviefavorites in
            DispatchQueue.main.async {
                self.movie = moviefavorites.results as! [Movie]
                self.CollectionView.reloadData()
                
            }
        }*/
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath as IndexPath) as! PeliculasCollectionViewCell
        var imageurl = "https://image.tmdb.org/t/p/w1280\(movie[indexPath.row].poster_path!)"
                  var url = URL(string: imageurl)
                  if let data = try? Data(contentsOf: url!){
                      cell.MovieiMAGE.image = UIImage(data: data)
                  }
        cell.id = movie[indexPath.row].id
        cell.Titlelbl.text = movie[indexPath.row].title
        cell.Popularitylbl.text = String(movie[indexPath.row].vote_average)
        cell.Fecha_lanzamientolbl.text = movie[indexPath.row].release_date
        cell.overview.text = movie[indexPath.row].overview
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
