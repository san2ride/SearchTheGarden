//
//  Constants.swift
//  TheAppGarden
//
//  Created by Jason Sanchez on 1/31/25.
//

import Foundation

struct Titles {
    static let gardenTitle = "Garden"
    static let gardenDetails = "Garden Details"
}

struct Urls {
    static func gardenAppURL(by query: String) -> URL? {
        return URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(query)")
    }
}
