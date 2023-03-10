//
//  FavViewController.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 09/03/23.
//

import UIKit

class FavViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
   
    var movieViewmodel = MovieViewModel()
    var ObjectsMovies = [Movie]()
    var IdDetail = 0
    
    @IBOutlet weak var favCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favCollectionView.delegate = self
        favCollectionView.dataSource = self
        view.addSubview(favCollectionView)
        self.favCollectionView.register(UINib(nibName: "PeliculasCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "Moviecell")
            }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()

    }
    
    func loadData(){
        ObjectsMovies = movieViewmodel.PersistenceGetFavorites()! as [Movie]
        self.favCollectionView.reloadData()
    }
    
    func deletemovie(posicion : Int){
        movieViewmodel.Delete(idDrink: posicion
        )
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ObjectsMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Moviecell", for: indexPath as IndexPath) as! PeliculasCollectionViewCell
        cell.Addfavoritesbutton.isHidden = true
        cell.Titlelbl.text = ObjectsMovies[indexPath.row].title
        cell.overview.text = ObjectsMovies[indexPath.row].overview
        cell.Fecha_lanzamientolbl.text = ObjectsMovies[indexPath.row].release_date
        cell.Popularitylbl.text = String(ObjectsMovies[indexPath.row].vote_average)
        cell.layer.cornerRadius = 10
        let url = URL(string: ObjectsMovies[indexPath.row].poster_path!)!
        if let data = try? Data(contentsOf: url){
            DispatchQueue.global().async {
                cell.MovieiMAGE.image = UIImage(data: data)
            }
        }
          
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "¿Que deseas hacer?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Detalles", style: .default){action in
            self.IdDetail = self.ObjectsMovies[indexPath.row].id
            self.performSegue(withIdentifier: "seguesdetailpersistence", sender: nil)
            
        })
        alert.addAction(UIAlertAction(title: "Eliminar", style: .destructive){
            action in
            self.deletemovie(posicion: indexPath.row)
            self.viewWillAppear(true)
        })
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        present(alert, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguesdetailpersistence"{
            let detail = segue.destination as! DetailViewController
            detail.IdDetail = IdDetail
            detail.tipo = "MOVIE"
            detail.segues = "seguesdetailpersistence"
            print(detail.IdDetail)
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
