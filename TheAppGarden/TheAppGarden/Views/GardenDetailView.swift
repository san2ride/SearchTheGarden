//
//  GardenDetailView.swift
//  TheAppGarden
//
//  Created by Jason Sanchez on 1/31/25.
//

import SwiftUI
import WebKit

struct GardenDetailView: View {
    let gardenItem: GardenItem
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: gardenItem.media.m)) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            Text(gardenItem.title)
                .font(.largeTitle)
            
            VStack(alignment: .center) {
                WebView(htmlContent: gardenItem.description)
            }
            Text(gardenItem.author)
            Text("Published: \(gardenItem.formattedPublishedDate)")
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
