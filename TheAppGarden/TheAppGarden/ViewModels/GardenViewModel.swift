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
    
    //MARK: Combine
    /*
    private var cancellables = Set<AnyCancellable>()

    func performSearch(query: String) {
        guard let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(query)") else {
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: GardenResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    print("Error fetching garden data")
                }
            }, receiveValue: { [weak self] gardenResponse in
                self?.gardenItems = gardenResponse.items
            })
            .store(in: &cancellables)
    }
    */
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
