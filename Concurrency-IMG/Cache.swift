//
//  Cache.swift
//  Concurrency-IMG
//
//  Created by vietanh on 1/22/18.
//  Copyright © 2018 vietanh. All rights reserved.
//

import Foundation
import UIKit

class Cache {
    static var cache: NSCache<NSURL, UIImage> = {
        let result = NSCache<NSURL, UIImage>()
        result.countLimit = 30
        result.totalCostLimit = 10 * 1024 * 1024
        return result
    }()
}

