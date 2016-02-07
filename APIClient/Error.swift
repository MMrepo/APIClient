//
//  Error.swift
//  APIClient
//
//  Created by Mateusz Małek on 07.02.2016.
//  Copyright © 2016 Mateusz Małek. All rights reserved.
//

import ObjectMapper

class Error: Mappable {
    
    required init()
    {
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    var message: String?
    var code: Int = -1
    
    // Mappable
    func mapping(mapper: Map) {
        message <- mapper["error.message"]
        code    <- mapper["error.code"]
    }
}