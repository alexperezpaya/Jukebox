//
//  NSURL+Argo.swift
//  Jukebox
//
//  Created by Alejandro on 26/05/15.
//  Copyright (c) 2015 jukebox. All rights reserved.
//

import Foundation

import Argo

extension NSURL: Decodable {
    public static func decode(json: JSON) -> Decoded<NSURL> {
        // We are receiving a string as parameter
        switch json {
        case .String(let urlString):
            return Decoded<NSURL>.fromOptional(NSURL(string: urlString))
        default:
            return Decoded<NSURL>.TypeMismatch("")
        }
    }
}