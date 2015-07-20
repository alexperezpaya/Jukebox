//
//  ItunesRequest.swift
//  Jukebox
//
//  Created by Alejandro on 27/05/15.
//  Copyright (c) 2015 jukebox. All rights reserved.
//

import Foundation

class ItunesRequest {

    class var sharedInstance: ItunesRequest {
        struct StaticInstance {
            static let instance = ItunesRequest()
        }
        return StaticInstance.instance
    }
    
    let apiRoot = "https://itunes.apple.com"
}
