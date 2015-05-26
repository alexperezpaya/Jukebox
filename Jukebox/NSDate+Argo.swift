//
//  NSDate+Argo.swift
//  Jukebox
//
//  Created by Alejandro on 26/05/15.
//  Copyright (c) 2015 jukebox. All rights reserved.
//

import Foundation

import Argo

// Conversion helper of string into time

extension NSDate: Decodable {
    public static func decode(json: JSON) -> Decoded<NSDate> {
        // We are receiving a string as parameter
        switch json {
        case .String(let dateString):
            let dateFormater = NSDateFormatter()
            dateFormater.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
            return Decoded<NSDate>.fromOptional(dateFormater.dateFromString(dateString))
        default:
            return Decoded<NSDate>.TypeMismatch("")
        }
    }
}