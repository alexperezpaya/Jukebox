//
//  NetworkTask.swift
//  Jukebox
//
//  Created by Alejandro on 27/05/15.
//  Copyright (c) 2015 jukebox. All rights reserved.
//

import Foundation

import Alamofire

enum NetworkResponse {
    case Success(NSHTTPURLResponse, AnyObject?)
    case Failure(NSHTTPURLResponse?, NSError, NetworkTask)
}

typealias NetworkRequest = Alamofire.Request

typealias NetworkRequestBuilder = () -> (NetworkRequest)
typealias NetworkTaskCallback = (NetworkResponse) -> ()

class NetworkTask {
//    let body: NetworkBody?
    
    let callback: NetworkTaskCallback
    let builder: NetworkRequestBuilder
    
    var request: NetworkRequest?
    
    init(builder: NetworkRequestBuilder, callback: NetworkTaskCallback) {
        self.builder = builder
        self.callback = callback
    }
    
    func try () {
        self.request = self.builder()
        self.request?.responseJSON { (req, res, json, err) in
            let builtResponse: NetworkResponse
            if let e = err {
                builtResponse = NetworkResponse.Failure(res, e, self)
            } else {
                builtResponse = NetworkResponse.Success(res!, json)
            }
            self.callback(builtResponse)
        }
    }
    
    func cancel () {
        self.request?.cancel()
    }
    
    func suspend () {
        self.request?.suspend()
    }
    
    func resume () {
        self.request?.resume()
    }
    
    func retry () {
        self.try()
    }

}