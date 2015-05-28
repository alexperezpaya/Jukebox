//
//  ViewController.swift
//  Jukebox
//
//  Created by Alejandro on 26/05/15.
//  Copyright (c) 2015 jukebox. All rights reserved.
//

import UIKit

class ArtistsViewController: UITableViewController {

    var collections = [AlbumCollection]()

    var manager = AlbumsManager(searchs: [
        AlbumsLookupSearch(id: 148662, limit: 10),
        AlbumsLookupSearch(id: 6906197, limit: 20),
        AlbumsLookupSearch(id: 16252655, limit: 7)
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ArtistsViewController {
    
    func loadData () {
        self.manager.fetch() { collections in
            self.collections = collections
            self.tableView.reloadData()
        }
    }
    
}

extension ArtistsViewController: UITableViewDataSource {
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
        
        cell?.textLabel?.text = collection.artist.artistName
        cell?.detailTextLabel?.text = "\(collection.albums.count) albums"
        cell?.imageView?.image = UIImage(data: NSData(contentsOfURL: NSURL(string: collection.albums[0].artworkUrl)!)!)
        
        return cell!
    }
    
}

extension ArtistsViewController: UITableViewDelegate {

}