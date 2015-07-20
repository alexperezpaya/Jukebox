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
    
    // Functional programing ftw :)
    // The haskell way
    
    // Sweet reads:
    
    // Parsers vs Argo
    // https://robots.thoughtbot.com/efficient-json-in-swift-with-functional-concepts-and-generics
    
    // https://robots.thoughtbot.com/functional-swift-for-dealing-with-optional-values
    // https://robots.thoughtbot.com/parsing-embedded-json-and-arrays-in-swift
    
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