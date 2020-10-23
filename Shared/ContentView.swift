//
//  ContentView.swift
//  Shared
//
//  Created by Abbas Mousavi on 7/25/20.
//

import SwiftUI
import GRDB
import Combine
import AVKit
import URLImage



struct ContentView: View {

    @ObservedObject var viewModel = model()
    
    
    var body: some View {
        
        TabView {
            
            MovieList(movieType: nil).tabItem {
                Text("All Movies")
                Image(systemName: "film")
            }
            
            MovieList(movieType: .comedy).tabItem {
                Text("Comedy")
                Image(systemName: "film")
            }
            
            MovieList(movieType: .noir).tabItem {
                Text("Noir")
                Image(systemName: "film")
            }
            
            MovieList(movieType: .horor).tabItem {
                Text("Horor, Sci-fi")
                Image(systemName: "film")
            }
            
            
            AboutPage().tabItem {Text("About")
                Image(systemName: "info.circle")
            }
            
        }.edgesIgnoringSafeArea(.all)
    }
}

extension View {
    func focusable(_: Bool) -> some View {
        return self
    }
}
