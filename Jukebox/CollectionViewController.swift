//
//  ViewController.swift
//  Jukebox
//
//  Created by Alejandro on 26/05/15.
//  Copyright (c) 2015 jukebox. All rights reserved.
//

import UIKit

import SVProgressHUD

class CollectionViewController: UITableViewController {

    var collections = [AlbumCollection]()

    var manager = AlbumsManager(searchs: [
        AlbumsLookupSearch(id: 148662, limit: 10),
        AlbumsLookupSearch(id: 6906197, limit: 20),
        AlbumsLookupSearch(id: 16252655, limit: 7)
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .None
        self.loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showArtistCollection" {
            if let i = sender as? Int {
                let vc = segue.destinationViewController as! ArtistCollectionViewController
                vc.collection = self.collections[i]
            }
        }
    }
    
    func loadData () {
        SVProgressHUD.showInfoWithStatus("Loading your music...")
        self.manager.fetch() { collections in
            SVProgressHUD.dismiss()
            self.collections = collections
            self.tableView.reloadData()
        }
    }

}

extension CollectionViewController: UITableViewDataSource {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collections.count
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "artistCell"

        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! UITableViewCell?
        
        if cell == nil  {
           cell = UITableViewCell(style: .Subtitle, reuseIdentifier: identifier)
        }
        
        let collection = self.collections[indexPath.row]
        
        let image = UIImage.loadImageFromUrlWithCache(NSURL(string: collection.recentAlbum()!.artworkUrl)!)
        
        cell?.textLabel?.text = collection.artist.artistName
        cell?.detailTextLabel?.text = "\(collection.albums.count) albums"
        cell?.imageView?.image = image
        
        // What we are doing here could take more time than expected
        // so lets process our image without blocking
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

extension CollectionViewController: UITableViewDelegate {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("showArtistCollection", sender: indexPath.row)
    }
}