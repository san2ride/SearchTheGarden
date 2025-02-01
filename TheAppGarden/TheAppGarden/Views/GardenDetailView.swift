//
//  GardenDetailView.swift
//  TheAppGarden
//
//  Created by Jason Sanchez on 1/31/25.
//

import SwiftUI
import WebKit

struct GardenDetailView: View {
    let vm: GardenViewModel
    @StateObject private var gardenGridViewModel = GardenGridViewModel()
    
    var body: some View {
        VStack {
            AsyncImage(url: vm.media) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            Text(vm.title)
                .font(.largeTitle)
            VStack(alignment: .center) {
                WebView(htmlContent: vm.description)
            }
            Text(vm.author)
            Text("Published: \(vm.published)")
        }
        .navigationTitle(Titles.gardenDetails)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//MARK: WKWebView htmlContent
struct WebView: UIViewRepresentable {
    let htmlContent: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
