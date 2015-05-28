//
//  UIImage+Cache.swift
//  Jukebox
//
//  Created by Alejandro on 28/05/15.
//  Copyright (c) 2015 jukebox. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImage {
    
    // We created this custom cache using SDWebImage for the storage abstraction
    // we need it so we can get images fastly and calculate our colors from them fast too :)
    static func loadImageFromUrlWithCache(url: NSURL) -> UIImage {
        let cache = SDImageCache()
        if let memoryImage = cache.imageFromMemoryCacheForKey(url.absoluteString!) {
            return memoryImage
        }
        
        if let diskImage = cache.imageFromDiskCacheForKey(url.absoluteString!) {
            return diskImage
        }
        
        let downloadedImage = UIImage(data: NSData(contentsOfURL: url)!)!
        SDImageCache().storeImage(downloadedImage, forKey: url.absoluteString!, toDisk: true)
        return downloadedImage
    }

}