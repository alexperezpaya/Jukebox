//
//  Album.swift
//  Jukebox
//
//  Created by Alejandro on 26/05/15.
//  Copyright (c) 2015 jukebox. All rights reserved.
//

import Foundation

import Argo
import Runes

struct Album {
    let artistId: Int
    let artistName: String
    let collectionName: String
    let artworkUrl: String
    let collectionPrice: Float
    let trackCount: Int
    let releaseDate: String
    
    static func create
        (artistId: Int)
        (artistName: String)
        (collectionName: String)
        (artworkUrl: String)
        (collectionPrice: Float)
        (trackCount: Int)
        (releaseDate: String)
        -> Album
    {
        return Album(
            artistId: artistId,
            artistName: artistName,
            collectionName: collectionName,
            artworkUrl: artworkUrl,
            collectionPrice: collectionPrice,
            trackCount: trackCount,
            releaseDate: releaseDate
        )
        
    }
    
}

extension Album: Decodable {
    static func decode(j: JSON) -> Decoded<Album> {
        return Album.create
            <^> j <| "artistId"
            <*> j <| "artistName"
            <*> j <| "collectionName"
            <*> j <| "artworkUrl"
            <*> j <| "collectionPrice"
            <*> j <| "trackCount"
            <*> j <| "releaseDate"
    }
}
