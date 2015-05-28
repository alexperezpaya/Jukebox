//
//  ArtistViewController.swift
//  Jukebox
//
//  Created by Alejandro on 28/05/15.
//  Copyright (c) 2015 jukebox. All rights reserved.
//

import Foundation
import UIKit

import SDWebImage
import ColorArt

class ArtistCollectionViewController: UITableViewController {
    var collection: AlbumCollection!
    
    override func viewDidLoad() {
        self.title = collection.artist.artistName
        self.navigationController?.title = collection.artist.artistName
        self.tableView.separatorStyle = .None
    }
    
}

extension ArtistCollectionViewController: UITableViewDataSource {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collection.albums.count
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "albumCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! UITableViewCell?
        
        if cell == nil  {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: identifier)
        }
        
        let album = self.collection.sortedAlbums()[indexPath.row]
        
        
        let image = UIImage.loadImageFromUrlWithCache(NSURL(string: album.artworkUrl)!)
        
        cell?.textLabel?.text = album.collectionName
        cell?.detailTextLabel?.text = "\(album.trackCount) tracks"
        cell?.imageView?.image = image
        
        dispatch_async(dispatch_get_main_queue()) {
            // Styling form image color palette
            let palette = image.colorArt(CGSize(width: 100, height: 100))
            cell?.backgroundColor = palette?.backgroundColor
            cell?.textLabel?.textColor = palette?.primaryColor
            cell?.detailTextLabel?.textColor = palette?.detailColor
        }
        
        return cell!
    }
}

extension ArtistCollectionViewController: UITableViewDelegate {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

