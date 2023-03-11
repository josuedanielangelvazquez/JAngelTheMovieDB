//
//  pruebacellCollectionViewCell.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 10/03/23.
//

import UIKit
import youtube_ios_player_helper
class pruebacellCollectionViewCell: UICollectionViewCell {
    var videoId = ""
    @IBOutlet weak var Videos: YTPlayerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        startvideo()
    }
    func startvideo(){
            let playerVars : [AnyHashable : Any] = ["playsinline":0, "controls":1, "autohide":1, "showinfo":0, "modesbranding":0]
        DispatchQueue.main.async { [self] in
            Videos.load(withVideoId: videoId, playerVars: playerVars)

        }
        }

}
