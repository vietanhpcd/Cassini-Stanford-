//
//  DemoURL.swift
//  Concurrency-IMG
//
//  Created by vietanh on 1/17/18.
//  Copyright © 2018 vietanh. All rights reserved.
//

import Foundation

struct DemoURL {
    static let stanford = URL(string: "https://cdn.spacetelescope.org/archives/images/large/heic1509a.jpg")
    static let NASA = [
            "Cassini" : "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
            "Earth" : "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
            "Saturn" : "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
        ]
    static func NASAImageNamed(imageName: String?) -> URL? {
        guard let urlString = NASA[imageName!] else {return stanford}
        return URL(string: urlString)
    }
}
