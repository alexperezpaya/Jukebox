//
//  ArtistViewModel.swift
//  Jukebox
//
//  Created by Alejandro on 28/05/15.
//  Copyright (c) 2015 jukebox. All rights reserved.
//

import Foundation

class AlbumsManager {
    
    var searchs: [AlbumsLookupSearch]
    var collections: [AlbumCollection]
    
    init (searchs: [AlbumsLookupSearch]) {
        self.searchs = searchs
        self.collections = [AlbumCollection]()
    }
    
    func fetch (callback: ([AlbumCollection]) -> ()) {
        self.collections = [AlbumCollection]() // We are fetching this again so we restart last collection
        for s in self.searchs {
            ItunesLookupAlbumsInteractor.request(s) { collection, failure in
                if let f = failure {
                    f.task.retry()
                } else {
                    self.collections.append(collection!)
                    callback(self.collections)
                }
            }
        }
    }

}
