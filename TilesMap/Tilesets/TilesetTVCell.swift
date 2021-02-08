//
//  TilesetTVCell.swift
//  TilesMap
//
//  Created by Ruzanna Ghazaryan on 2/6/21.
//

import UIKit

class TilesetTVCell: UITableViewCell {
    static let cellId = "TilesetTVCell"
    
    @IBOutlet weak var thumbImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func fill(tileName: String?, thumbnail: String?) {
        nameLabel.text = tileName
        if let urlStr = thumbnail  {
            thumbImgView.loadImage(urlString: urlStr, placeholderImage: UIImage(named: "tlleset_placeholder"))
        }  else {
            thumbImgView.image = UIImage(named: "tlleset_placeholder")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImgView.image = nil
    }
}
