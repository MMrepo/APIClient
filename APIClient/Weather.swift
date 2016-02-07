//
//  Weather.swift
//  APIClient
//
//  Created by Mateusz Małek on 07.02.2016.
//  Copyright © 2016 Mateusz Małek. All rights reserved.
//

import CoreLocation
import ObjectMapper

class Weather: Mappable {
    
    required init()
    {
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    var latitude:CLLocationDegrees?
    var longitude:CLLocationDegrees?
    var id: Int = -1
    var main: String?
    var description: String?
    var temp: Float?
    
    var coordinate:CLLocationCoordinate2D? {
        if let lat = latitude, let lng = longitude {
            return CLLocationCoordinate2DMake(lat, lng)
        } else {
            return nil
        }
    }
    
    // Mappable
    func mapping(mapper: Map) {
        latitude <- mapper["coord.lat"]
        longitude <- mapper["coord.lon"]
        id <- mapper["id"]
        main <- mapper["weather.0.main"]
        description <- mapper["weather.0.description"]
        temp  <- mapper["main.temp"]
    }
}