//
//  APIClientRouterProtocol+Default.swift
//  APIClient
//
//  Created by Mateusz Małek on 07.02.2016.
//  Copyright © 2016 Mateusz Małek. All rights reserved.
//

import Alamofire

extension APIClientRouterProtocol {
    var method: Alamofire.Method {
        return .GET
    }
    
    var baseURLString: String {
        return ""
    }
    
    var path: String {
        return ""
    }
    
    var parameters: [String : AnyObject]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return .JSON
    }
    
    var needsAuthenticationToken: Bool {
        return false
    }
    
    var accessToken: String? {
        return ""
    }
    
    var URLRequest: NSMutableURLRequest {
        var mutableURLRequest = NSMutableURLRequest(URL: requestURL)
        mutableURLRequest = addTokenHeaderIfNeededToRequest(mutableURLRequest)
        mutableURLRequest.HTTPMethod = method.rawValue
        return parameterEncoding.encode(mutableURLRequest, parameters: parameters).0
    }
    
    var allowEmptyResponse: Bool {
        return false
    }
    
    //MARK: - Utilities
    private var requestURL:NSURL {
        return NSURL(string: "\(baseURLString)\(path)")!
    }
    
    private func addTokenHeaderIfNeededToRequest(mutableURLRequest:NSMutableURLRequest) -> NSMutableURLRequest {
        if needsAuthenticationToken == true, let token = accessToken {
            mutableURLRequest.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return mutableURLRequest
    }
}