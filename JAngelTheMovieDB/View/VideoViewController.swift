//
//  VideoViewController.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 10/03/23.
//

import UIKit
import youtube_ios_player_helper
class VideoViewController: UIViewController{
    
   var moviesvideos = ["z-E5pTQVW8w", "bEoNNYyVNxc", "feQClhJLX5c"]
    
    @IBOutlet weak var VIDEOPLAYER: YTPlayerView!
    
    @IBOutlet weak var MoviesCollectionView: UICollectionView!
    var videoId : String = "bEoNNYyVNxc"
    
    override func viewDidLoad() {
       super.viewDidLoad()
   /*     MoviesCollectionView.delegate = self
        MoviesCollectionView.dataSource = self
        view.addSubview(MoviesCollectionView)
        self.MoviesCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "VideoCollectioncell")
        MoviesCollectionView.reloadData()*/
        startvideo()
    }
    
    func startvideo(){
            let playerVars : [AnyHashable : Any] = ["playsinline":1, "controls":1, "autohide":1, "showinfo":0, "modesbranding":0]
            
                VIDEOPLAYER.load(withVideoId: videoId, playerVars: playerVars)
        }
 
   /* func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectioncell", for: indexPath as IndexPath) as! CollectionViewCell
            cell.videoId = moviesvideos[indexPath.row]
        return cell
    }
    */

    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

/*extension VideoViewController : YTPlayerViewDelegate{
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}*/

