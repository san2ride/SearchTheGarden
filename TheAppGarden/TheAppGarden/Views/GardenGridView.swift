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
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(gardenGridViewModel.gardenItems, id: \.media) { vm in
                        NavigationLink(destination: GardenDetailView(vm: vm)) {
                            VStack {
                                AsyncImage(url: vm.media) { image in
                                    image.resizable()
                                        .frame(maxWidth: 100, maxHeight: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }.padding()
            }
            .searchable(text: $query)
            .onChange(of: query) { value in
                if !value.isEmpty {
                    Task {
                        await gardenGridViewModel.performSearch(query: value)
                    }
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
