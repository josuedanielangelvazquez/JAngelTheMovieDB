//
//  MoviesViewController.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 02/02/23.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   let PeliculasViewModel = MovieViewModel()
    let ontvViewModel = OnTVViewModel()
    var ontv = [OnTV]()
    var movie = [Movie]()
    var TVORMovie = "MOVIE"
    var count = 0
    var idMovieTv = 0
    
    @IBOutlet weak var Seccionsegment: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Seccionsegment.tintColor = .white
        collectionView.delegate = self
             collectionView.dataSource = self
             view.addSubview(collectionView)
        Seccionsegment.tintColor = .white
        self.collectionView.register(UINib(nibName: "PeliculasCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "Moviecell")
     loadDataPopularMovie()
        // Do any additional setup after loading the view.
    }
    func loadDataPopularMovie(){
        TVORMovie = "MOVIE"
        let result = PeliculasViewModel.getPopular(){ MoviesJSON in
            DispatchQueue.main.async {
                self.movie = MoviesJSON.results as! [Movie]
                self.collectionView.reloadData()
                self.count = self.movie.count
            }
        }
    }
    func loadDataTopRated(){
        TVORMovie = "MOVIE"
        let result = PeliculasViewModel.GetTopRated { TopRated in
            DispatchQueue.main.async {
                self.movie = TopRated.results as! [Movie]
                self.collectionView.reloadData()
                self.count = self.movie.count
            }
        }
    }
    func loadDataOnTV(){
        TVORMovie = "TV"
        let result = ontvViewModel.GetOnTV { OnTv in
            DispatchQueue.main.async {
                self.ontv = OnTv.results as! [OnTV]
                self.collectionView.reloadData()
                self.count = self.ontv.count
            }
        }
    }
    func loadDataAiringToday(){
        TVORMovie = "TV"
        let result = ontvViewModel.GetAiringToday { AiringToday in
            DispatchQueue.main.async {
                self.ontv = AiringToday.results as! [OnTV]
                self.collectionView.reloadData()
                self.count = self.ontv.count
            }
        }
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Moviecell", for: indexPath as IndexPath) as!  PeliculasCollectionViewCell
        if TVORMovie.elementsEqual("MOVIE"){
            var imageurl = "https://image.tmdb.org/t/p/w1280\(movie[indexPath.row].poster_path!)"
            var url = URL(string: imageurl)
            if let data = try? Data(contentsOf: url!){
                cell.MovieiMAGE.image = UIImage(data: data)
            }
            
            cell.Titlelbl.text = movie[indexPath.row].title
            cell.Popularitylbl.text = String(movie[indexPath.row].vote_average)
            cell.Fecha_lanzamientolbl.text = movie[indexPath.row].release_date
            cell.overview.text = movie[indexPath.row].overview
            cell.id = movie[indexPath.row].id
        }
        else{
            var imagenurl = "https://image.tmdb.org/t/p/w1280\(ontv[indexPath.row].poster_path!)"
            var url = URL(string: imagenurl)!
            if let data = try? Data(contentsOf: url){
                cell.MovieiMAGE.image = UIImage(data: data)
            }
            cell.Titlelbl.text = ontv[indexPath.row].name
            cell.Popularitylbl.text = String(movie[indexPath.row].vote_average)
            cell.Fecha_lanzamientolbl.text = ontv[indexPath.row].first_air_date
            cell.overview.text = ontv[indexPath.row].overview
            cell.id = ontv[indexPath.row].id
        }
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           if TVORMovie.elementsEqual("MOVIE"){
             self.idMovieTv = movie[indexPath.row].id
             performSegue(withIdentifier: "seguesmovie", sender: nil)
             print(self.idMovieTv)
         }
         else{
             self.idMovieTv = ontv[indexPath.row].id
            performSegue(withIdentifier: "seguesmovie", sender: nil)
             print(self.idMovieTv)
         }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguesmovie"{
            let detail = segue.destination as! DetailViewController
            detail.IdDetail = self.idMovieTv
            detail.tipo = self.TVORMovie
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

    @IBAction func AccionMostrar(_ sender: Any) {
        let getIndex = Seccionsegment.selectedSegmentIndex
        
        switch(getIndex){
        case 0:
            loadDataPopularMovie()
            break
        case 1:
            loadDataTopRated()
        case 2:
            loadDataOnTV()
        case 3:
            loadDataAiringToday()
            
            
        default:
            print("No hay mas opciones")
        }
        
    }
    
    @IBAction func BurguerMenuAction(_ sender: Any) {
        let alert = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "View Profile", style: .default){action in
            self.Cambiosegues()
        })
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        self.present(alert, animated: true)

    }
    func Cambiosegues(){
        performSegue(withIdentifier: "seguesProfile", sender: nil)
    }
    
    
}
