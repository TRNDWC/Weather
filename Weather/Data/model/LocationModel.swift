//
//  LocationModel.swift
//  Weather
//
//  Created by Trần Đức on 14/8/24.
//

import Foundation

class LocationEntity: Decodable {
    let placeId: Int
    let licence: String
    let osmType: String
    let osmId: Int
    let latitude: String
    let longitude: String
    let boundaryClass: String
    let type: String
    let placeRank: Int
    let importance: Double
    let addressType: String
    let name: String
    let displayName: String
    let boundingBox: [String]

    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case licence
        case osmType = "osm_type"
        case osmId = "osm_id"
        case latitude = "lat"
        case longitude = "lon"
        case boundaryClass = "class"
        case type
        case placeRank = "place_rank"
        case importance
        case addressType = "addresstype"
        case name
        case displayName = "display_name"
        case boundingBox = "boundingbox"
    }
}

class LocationModel : Equatable{
    var name : String
    var latitude : String
    var longitude : String
    var time : Date?
    
    init(name: String, latitude: String, longitude: String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(from entity: LocationEntity) {
        self.name = entity.name
        self.latitude = entity.latitude
        self.longitude = entity.longitude
    }
    
    init(fromCore entity: CoreDataLocation) {
        self.name = entity.name ?? ""
        self.latitude = entity.latitude ?? ""
        self.longitude = entity.longitude ?? ""
        self.time = entity.createTime
    }

    
    static func == (lhs: LocationModel, rhs: LocationModel) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
