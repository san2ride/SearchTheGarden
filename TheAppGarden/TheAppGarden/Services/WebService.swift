//
//  WebService.swift
//  TheAppGarden
//
//  Created by Jason Sanchez on 1/31/25.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badUrl
    case invalidData
}

class WebService {    
    func load(url: URL?) async throws -> [Garden] {
        guard let url = url else {
            throw NetworkError.badUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidData
        }
        let gardenResponse =  try JSONDecoder().decode(GardenResponse.self, from: data)
        
        return gardenResponse.items
    }
}
