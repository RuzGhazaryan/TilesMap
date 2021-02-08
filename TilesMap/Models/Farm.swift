//
//  Flights.swift
//  TilesMap
//
//  Created by Ruzanna Ghazaryan on 2/6/21.
//

import Foundation

struct Farm: Codable {
    var geometry: String?
    var latitude: Double?
    var longitude: Double?
    var thumbnail: String?
    var tilesets: [Tile]?
    
    private enum CodingKeys: String, CodingKey {
        case geometry
        case tilesets = "flights"
        case latitude = "centerLatitude"
        case longitude = "centerLongitude"
        case thumbnail = "thumbnailPath"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.geometry = try? container.decode(String.self, forKey: .geometry)
        self.latitude = try? container.decode(Double.self, forKey: .latitude)
        self.longitude = try? container.decode(Double.self, forKey: .longitude)
        self.thumbnail = try? container.decode(String.self, forKey: .thumbnail)
        let flights = try! container.decode([Tilesets].self, forKey: .tilesets)
        self.tilesets = flights[0].tilesets
    }
}

extension Farm {
    struct Tilesets: Codable {
        var tilesets: [Tile]?
    }
}
