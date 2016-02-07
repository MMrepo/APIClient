//
//  APIClientRouterProtocl+ExampleExtension.swift
//  APIClient
//
//  Created by Mateusz Małek on 07.02.2016.
//  Copyright © 2016 Mateusz Małek. All rights reserved.
//

import Alamofire
import PromiseKit

enum APIClientRouterExample: APIClientRouterProtocol {
    
    //MARK: Cases
    case GetWeatherByCityName(String)
    case GetWeatherByCityID(String)
    
    // MARK: URLRequestConvertible
    var method: Alamofire.Method {
        switch self {
        case .GetWeatherByCityName, .GetWeatherByCityID:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .GetWeatherByCityName, .GetWeatherByCityID:
            return "/data/2.5/weather"
        }
    }
    
    var parameters: [String : AnyObject]? {
        switch self {
        case .GetWeatherByCityName(let cityName):
            return ["q": cityName, "APPID": apiKey]
        case .GetWeatherByCityID(let cityID):
            return ["id": cityID, "APPID": apiKey]
        }
    }
    
    var needsAuthenticationToken: Bool {
        return false
    }
    
    var baseURLString: String {
        return "http://api.openweathermap.org"
    }
    
    var apiKey: String {
        return "" //API KEY Here
    }
    
    var parameterEncoding: ParameterEncoding {
        return .URL
    }
}

extension APIClient {
    
    class func getWeatherFromCityNamed(cityName:String) -> Promise<Weather> {
        return sendRequest(APIClientRouterExample.GetWeatherByCityName(cityName)).responseObject()
    }
    
    class func getWeatherFromCityWithID(cityID:String) -> Promise<Weather> {
        return sendRequest(APIClientRouterExample.GetWeatherByCityID(cityID)).responseObject()
    }
}