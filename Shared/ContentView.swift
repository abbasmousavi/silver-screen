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
    
    let columns = [
        GridItem(.flexible(minimum: 0, maximum: .infinity)),
        
    ]
    
    let rows = [
        GridItem(.flexible(minimum: 0, maximum: .infinity)),
    ]
    
    
    var body: some View {
        
        TabView {
            
            MovieList(movieType: nil).tabItem {
                Text("All Movies")
            }
            
            MovieList(movieType: .comedy).tabItem {
                Text("Comedy")
            }
            
            MovieList(movieType: .noir).tabItem {
                Text("Noir")
            }
            
            MovieList(movieType: .horor).tabItem {
                Text("Horor, Sci-fi")
            }
            
            
            AboutPage().padding(.horizontal, 200).tabItem {Text("About")}
            
        }.edgesIgnoringSafeArea(.all)
    }
}

extension View {
    func focusable(_: Bool) -> some View {
        return self
    }
}





struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}



//func headerView(type: String) -> some View{
//    return HStack {
//        Spacer()
//        Text("Section header \(type)")
//        Spacer()
//    }.padding(.all, 10).background(Color.blue)
//}


//struct PlayerOverLay: View {
//    let action: () -> ()
//
//    var body: some View {
//
//        Text("dff")
//
//
//    }
//
//}
//


//final class Loader: ObservableObject {
//
//    var task: URLSessionDataTask!
//    @Published var data: Data? = nil
//
//    init(_ url: URL) {
//        task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
//            DispatchQueue.main.async {
//                self.data = data
//            }
//        })
//        task.resume()
//    }
//    deinit {
//        task.cancel()
//    }
//}

//let placeholder = UIImage(named: "poster-placeholder")!
//
//struct AsyncImage: View {
//    init(url: URL) {
//        self.imageLoader = Loader(url)
//    }
//
//    @ObservedObject private var imageLoader: Loader
//    var image: UIImage? {
//        imageLoader.data.flatMap(UIImage.init)
//    }
//
//
//    var body: some View {
//        Image(uiImage: image ?? placeholder)
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//        // .clipped()
//    }
//}
