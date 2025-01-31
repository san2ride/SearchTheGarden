//
//  GardenGridViewModel.swift
//  TheAppGarden
//
//  Created by Jason Sanchez on 1/31/25.
//

import Foundation
import Combine

class GardenGridViewModel: ObservableObject {
    @Published var gardenItems: [GardenItem] = []
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
}
