//
//  VideoViewController2.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 10/03/23.
//

import UIKit
import youtube_ios_player_helper
class VideoViewController2: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var movieviewmodel = MovieViewModel()
    var TrailersMovies = [results]()
    var videoId = ""
    @IBOutlet weak var Youtube: YTPlayerView!
    
    @IBOutlet weak var Youtube2: YTPlayerView!
    
    @IBOutlet weak var VideosCollectionVIew: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VideosCollectionVIew.delegate = self
            VideosCollectionVIew.dataSource = self
            view.addSubview(VideosCollectionVIew)
            self.VideosCollectionVIew.register(UINib(nibName: "pruebacellCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "videocell")
            VideosCollectionVIew.reloadData()
        startvideo()
        loadData()
    }
    func loadData(){
        movieviewmodel.getvideosMovies(IdMovie: 315162) { [self] ObjectsVideos in
            DispatchQueue.main.async {
                if ObjectsVideos?.results != nil{
                    TrailersMovies = ObjectsVideos?.results as! [results]
                    VideosCollectionVIew.reloadData()
                }
                else{
                    print("Se regresaron los datos vacios")
                }
            }
         
        }
    }
    func startvideo(){
            let playerVars : [AnyHashable : Any] = ["playsinline":1, "controls":1, "autohide":1, "showinfo":0, "modesbranding":0]
            
                Youtube.load(withVideoId: videoId, playerVars: playerVars)
        Youtube2.load(withVideoId: videoId, playerVars: playerVars)
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        TrailersMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videocell", for: indexPath as IndexPath) as! pruebacellCollectionViewCell
        cell.videoId = TrailersMovies[indexPath.row].key
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
