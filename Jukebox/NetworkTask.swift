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
    case Success(NSHTTPURLResponse)
    case Failure(Int, NSError, NetworkTask)
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
        self.request?
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { (req, res, dict, err) in
                let builtResponse: NetworkResponse
                if (err != nil) {
                    builtResponse = NetworkResponse.Failure(res?.statusCode ?? err!.code, err!, self)
                } else {
                    builtResponse = NetworkResponse.Success(res!)
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