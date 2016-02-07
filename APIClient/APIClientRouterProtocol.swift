//
//  APIClientRouterProtocol.swift
//  APIClient
//
//  Created by Mateusz Małek on 07.02.2016.
//  Copyright © 2016 Mateusz Małek. All rights reserved.
//

import Alamofire

protocol APIClientRouterProtocol: URLRequestConvertible {
    var method: Alamofire.Method { get }
    var baseURLString: String { get }
    var path: String { get }
    var parameters: [String : AnyObject]? { get }
    var parameterEncoding: ParameterEncoding { get }
    var needsAuthenticationToken: Bool { get }
    var allowEmptyResponse: Bool { get }
}
