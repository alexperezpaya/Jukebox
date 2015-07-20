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
                    // We want our task to be retried if it fails
                    // So user is agnostic of network problems
                    
                    // This is the main reason to create network tasks,
                    // so we can have a generic way to manage our failures in requests
                    f.task.retry()

                } else {
                    
                    // Its good if we are here :)
                    // Return the callback and paint our view!
                    
                    self.collections.append(collection!)
                    callback(self.collections)

                }
            }
        }
    }

}
