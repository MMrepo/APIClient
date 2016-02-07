//
//  APIClient.swift
//  APIClient
//
//  Created by Mateusz Małek on 07.02.2016.
//  Copyright © 2016 Mateusz Małek. All rights reserved.
//

import Alamofire
import PromiseKit
import ObjectMapper
import Timberjack
import netfox
import Locksmith

class APIClientHTTPManager: Alamofire.Manager
{
    private static var logging = true
    
    internal override func request(URLRequest: URLRequestConvertible) -> Request {
        let request = super.request(URLRequest)
        if let body = request.request?.HTTPBody where APIClientHTTPManager.logging == true {
            if let bodyString = NSString(data: body, encoding: NSUTF8StringEncoding) {
                Timberjack().logDivider()
                print("Request body: \(bodyString)")
            }
        }
        return request
    }

    static let sharedManager: APIClientHTTPManager = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        if logging == true {
            configuration.protocolClasses?.insert(NFXProtocol.self, atIndex: 0)
            configuration.protocolClasses?.insert(Timberjack.self, atIndex: 0)
            
            configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        }
        let manager = APIClientHTTPManager(configuration: configuration)
        return manager
    }()
}

class APIClient {
    
    private let httpManager: Alamofire.Manager
    private let notificationCenter: NSNotificationCenter

    //MARK: Initialization
    static let sharedInstance: APIClient = {
        let apiClient = APIClient()
        return apiClient
    }()
    
    init(httpManager manager: Alamofire.Manager = APIClientHTTPManager.sharedManager, notificationCenter center: NSNotificationCenter = NSNotificationCenter.defaultCenter()) {
        httpManager = manager
        notificationCenter = center
    }
    
    class func sendRequest(request:URLRequestConvertible) -> Request {
        return APIClientHTTPManager.sharedManager.request(request)
    }
}