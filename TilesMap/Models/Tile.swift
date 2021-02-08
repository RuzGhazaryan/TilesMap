//
//  Tile.swift
//  TilesMap
//
//  Created by Ruzanna Ghazaryan on 2/6/21.
//

import Foundation

struct Tile: Codable {
    var name: String?
    var path: String?
    var thumbnail: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case path
        case thumbnail = "exportGeotiffThumbnail"
    }
}
