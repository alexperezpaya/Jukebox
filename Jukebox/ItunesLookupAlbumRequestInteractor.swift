//
//  ItunesLookupAlbumRequestInteractor.swift
//  Jukebox
//
//  Created by Alejandro on 28/05/15.
//  Copyright (c) 2015 jukebox. All rights reserved.
//

import Foundation
import Argo

struct AlbumsLookupSearch {
    let id: Int
    let limit: Int?
}

struct ItunesLookupAlbumsInteractorFailure {
    let resp: NSURLResponse?
    let error: NSError
    let task: NetworkTask
}

class ItunesLookupAlbumsInteractor {
    static func request(albumsSearch: AlbumsLookupSearch, callback: (AlbumCollection?, ItunesLookupAlbumsInteractorFailure?) -> ()) {
        ItunesRequest.sharedInstance.lookup(albumsSearch.id, entity: "album", media: "music", limit: albumsSearch.limit ?? 0) { result in
            switch result {
            case .Success(let resp, let json):
                let typedJson = json! as! [String: AnyObject]
                var artist: Artist?
                var albums = [Album]()

                for result in (typedJson["results"] as! [[String: AnyObject]]) {
                    let parsedJson = JSON.parse(result)
                    switch (result["wrapperType"] as! String!) {
                        case "artist":
                            artist = Artist.decode(parsedJson).value!
                        case "collection":
                            albums.append(Album.decode(parsedJson).value!)
                        default:
                            println("Unknown type")
                    }
                }

                callback(AlbumCollection(artist: artist!, albums: albums), nil)
            
            case .Failure(let resp, let error, let task):
                callback(nil, ItunesLookupAlbumsInteractorFailure(resp: resp, error: error, task: task))
            }
        }
    }
    
}