//
//  AlbumCollection.swift
//  Jukebox
//
//  Created by Alejandro on 28/05/15.
//  Copyright (c) 2015 jukebox. All rights reserved.
//

import Foundation

struct AlbumCollection {
    let artist: Artist
    let albums: [Album]
}

extension AlbumCollection {

    func recentAlbum() -> Album? {
        return sortedAlbums().first
    }
    
    func sortedAlbums() -> [Album] {
        var sortedAlbums = self.albums
        sortedAlbums.sort { left, right in
            left.releaseDate.compare(right.releaseDate) == NSComparisonResult.OrderedDescending
        }
        return sortedAlbums
    }

}