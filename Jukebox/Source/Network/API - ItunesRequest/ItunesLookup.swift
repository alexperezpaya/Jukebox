//
//  ItunesLookupRequest.swift
//  Jukebox
//
//  Created by Alejandro on 27/05/15.
//  Copyright (c) 2015 jukebox. All rights reserved.
//

import Foundation
import Alamofire

extension ItunesRequest {

    func lookup (id: Int?, entity: String?, media: String?, limit: Int?, callback: NetworkTaskCallback) {

        var parameters = [String: AnyObject]()

        parameters["id"] = id
        parameters["entity"] = entity
        parameters["media"] = media
        parameters["limit"] = limit
        
        let requestTask = NetworkTask(builder: {
            return Alamofire.request(
                Alamofire.Method.GET,
                "\(self.apiRoot)/lookup",
                parameters: parameters,
                encoding: ParameterEncoding.URL
            )
        }, callback: callback)
        
        requestTask.try()
        
    }

}
