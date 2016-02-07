//
//  ServerError.swift
//  APIClient
//
//  Created by Mateusz Małek on 07.02.2016.
//  Copyright © 2016 Mateusz Małek. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import PromiseKit

enum ServerError: ErrorType {
    
    static private let mapper = Mapper<Error>()
    
    case Unknown(Error)
    case Internal(Error)
    case Unauthorized(Error)
    
    func message() -> String {
        switch self {
        case .Unknown(let errorModel):
            return errorModel.message ?? ""
        case .Internal(let errorModel):
            return errorModel.message ?? ""
        case .Unauthorized(let errorModel):
            return errorModel.message ?? ""
        }
    }
    
    static func serverErrorWithMessage(message: String) -> ServerError {
        let serverError = Error()
        serverError.message = message
        return Unknown(serverError)
    }
    
    static func serverErrorFromNSError(nsError: NSError, errorCode:Int? = nil) -> ServerError {
        let serverError = Error()
        serverError.message = nsError.localizedDescription
        serverError.code = errorCode ?? -1
        switch errorCode {
        case 401?:
            return Unauthorized(serverError)
        case 500?:
            return Internal(serverError)
        default:
            return Unknown(serverError)
        }
    }
    
    static func getErrorFromResponse(response:Response<String, NSError>) -> ServerError? {
        if let foundError = response.result.error {
            return ServerError.serverErrorFromNSError(foundError, errorCode: response.response?.statusCode)
        }
        else {
            return nil
        }
    }
}

extension ErrorType {
    public func message() -> String {
        if let serverError = self as? ServerError {
            return serverError.message()
        }
        else {
            return "\(self)"
        }
    }
}