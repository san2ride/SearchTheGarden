//
//  GardenViewModel.swift
//  TheAppGarden
//
//  Created by Jason Sanchez on 1/31/25.
//

import Foundation

class GardenGridViewModel: ObservableObject {
    @Published var gardenItems: [GardenViewModel] = []
    
    func performSearch(query: String) async {
        do {
            let gardenItems = try await WebService().load(url: Urls.gardenAppURL(by: query))
            DispatchQueue.main.async {
                self.gardenItems = gardenItems.map(GardenViewModel.init)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct GardenViewModel {
    let garden: Garden
    
    init(garden: Garden) {
        self.garden = garden
    }
    
    var title: String {
        garden.title
    }
    
    var media: URL? {
        URL(string: garden.media.m)
    }
    
    var description: String {
        garden.description
    }
    
    var published: String {
        garden.formattedPublishedDate
    }
    
    var author: String {
        garden.author
    }
}
