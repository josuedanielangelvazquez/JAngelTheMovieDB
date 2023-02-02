//
//  MoviesViewController.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 02/02/23.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   let PeliculasViewModel = MovieViewModel()
    var movies = [Movie]()
    var movie = [Movie]()
    
    @IBOutlet weak var Seccionsegment: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
             collectionView.dataSource = self
             view.addSubview(collectionView)
        Seccionsegment.tintColor = .white
        self.collectionView.register(UINib(nibName: "PeliculasCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "Moviecell")
        loadData()
        // Do any additional setup after loading the view.
    }
    func loadData(){
        let result = PeliculasViewModel.getPopular(){ MoviesJSON in
            DispatchQueue.main.async {
                self.movie = MoviesJSON.results as! [Movie]
                self.collectionView.reloadData()

            }

        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Moviecell", for: indexPath as IndexPath) as!  PeliculasCollectionViewCell
        var imageurl = "https://image.tmdb.org/t/p/w1280\(movie[indexPath.row].poster_path!)"
        print(imageurl)
        var url = URL(string: imageurl)
        if let data = try? Data(contentsOf: url!){
            cell.MovieiMAGE.image = UIImage(data: data)

        }
        cell.image = movie[indexPath.row].poster_path!
        cell.Titlelbl.text = movie[indexPath.row].title
        cell.Popularitylbl.text = String(movie[indexPath.row].popularity)
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
