//
//  PeliculasCollectionViewCell.swift
//  JAngelTheMovieDB
//
//  Created by MacBookMBA6 on 02/02/23.
//

import UIKit

class PeliculasCollectionViewCell: UICollectionViewCell {
    var id = 0
    @IBOutlet weak var MovieiMAGE: UIImageView!
    
    @IBOutlet weak var Titlelbl: UILabel!
    @IBOutlet weak var Fecha_lanzamientolbl: UILabel!
    @IBOutlet weak var Popularitylbl: UILabel!
    
    @IBOutlet weak var overview: UILabel!
    
    override func awakeFromNib() {
    
        // Initialization code
    }

}
