//
//  GardenGridView.swift
//  TheAppGarden
//
//  Created by Jason Sanchez on 1/31/25.
//

import SwiftUI

struct GardenGridView: View {
    @State private var query: String = ""
    @StateObject private var gardenGridViewModel = GardenGridViewModel()

    let columns = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        NavigationView {
            LazyVGrid(columns: columns) {
                ForEach(gardenGridViewModel.gardenItems, id: \.media) { garden in
                    NavigationLink(destination: GardenDetailView(gardenItem: garden)) {
                        VStack {
                            AsyncImage(url: URL(string: garden.media.m ?? "")) { image in
                                image.resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }.padding()
            .searchable(text: $query)
            .onChange(of: query) { value in
                if !value.isEmpty {
                    gardenGridViewModel.performSearch(query: value)
                } else {
                    gardenGridViewModel.gardenItems = []
                }
            }
            .navigationTitle(Titles.gardenTitle)
        }
    }
}

#Preview {
    GardenGridView()
}
