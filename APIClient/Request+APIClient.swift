//
//  Request+APIClient.swift
//  APIClient
//
//  Created by Mateusz Małek on 07.02.2016.
//  Copyright © 2016 Mateusz Małek. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import ObjectMapper

extension Request {
    public func responseObject<T:Mappable>(
        encoding encoding: NSStringEncoding? = nil)
        -> Promise<T>
    {
        return Promise { fulfill, reject in
            responseString { (response:Response<String, NSError>) in
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    if let error = ServerError.getErrorFromResponse(response) {
                        dispatch_async(dispatch_get_main_queue(), {
                            reject(error)
                        })
                    }
                    else if let object:T = Mapper<T>().map(response.result.value){
                        dispatch_async(dispatch_get_main_queue(), {
                            fulfill(object)
                        })
                    }
                })
            }
        }
    }
    
    public func responseObjectsArray<T:Mappable>(
        encoding encoding: NSStringEncoding? = nil)
        -> Promise<[T]>
    {
        return Promise { fulfill, reject in
            responseString { (response:Response<String, NSError>) in
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    if let error = ServerError.getErrorFromResponse(response) {
                        dispatch_async(dispatch_get_main_queue(), {
                            reject(error)
                        })
                    }
                    else if let objects:[T] = Mapper<T>().mapArray(response.result.value){
                        dispatch_async(dispatch_get_main_queue(), {
                            fulfill(objects)
                        })
                    }
                })
            }
        }
    }
}