//
//  Artist.swift
//  Jukebox
//
//  Created by Alejandro on 26/05/15.
//  Copyright (c) 2015 jukebox. All rights reserved.
//

import Foundation

import Argo
import Runes

struct Artist {
    let artistType: String
    let artistName: String
    let artistId: Int
    let amgArtistId: Int
    let primaryGenreName: String
    let primaryGenreId: Int
}

extension Artist: Decodable {
    
    static func create
        (artistType: String)
        (artistName: String)
        (artistId: Int)
        (amgArtistId: Int)
        (primaryGenreName: String)
        (primaryGenreId: Int)
        -> Artist
    {
        return Artist(
            artistType: artistType,
            artistName: artistName,
            artistId: artistId,
            amgArtistId: amgArtistId,
            primaryGenreName: primaryGenreName,
            primaryGenreId: primaryGenreId
        )
    }
    
    static func decode(j: JSON) -> Decoded<Artist> {
        return Artist.create
            <^> j <| "artistType"
            <*> j <| "artistName"
            <*> j <| "artistId"
            <*> j <| "amgArtistId"
            <*> j <| "primaryGenreName"
            <*> j <| "primaryGenreId"
    }
}