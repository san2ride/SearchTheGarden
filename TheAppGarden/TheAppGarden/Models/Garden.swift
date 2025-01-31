//
//  Garden.swift
//  TheAppGarden
//
//  Created by Jason Sanchez on 1/31/25.
//

import Foundation

struct GardenResponse: Codable {
    let items: [GardenItem]
}

struct GardenItem: Codable {
    let title: String
    let media: GardenMedia
    let description: String
    let published: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case title, media, description, published, author
    }
    
    var formattedPublishedDate: String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        
        if let date = formatter.date(from: published) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return "Unknown Date"
    }
}

struct GardenMedia: Codable, Hashable {
    let m: String?
}
