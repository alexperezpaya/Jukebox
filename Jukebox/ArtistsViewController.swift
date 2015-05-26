//
//  ViewController.swift
//  Jukebox
//
//  Created by Alejandro on 26/05/15.
//  Copyright (c) 2015 jukebox. All rights reserved.
//

import UIKit

class ArtistsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ArtistsViewController: UITableViewDataSource {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
        
        cell?.textLabel?.text = "ODA"
        cell?.detailTextLabel?.text = "MOFO"
        cell?.imageView?.image = UIImage(named: "jacku")
        
        return cell!
    }
    
}

extension ArtistsViewController: UITableViewDelegate {

}