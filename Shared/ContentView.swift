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
import SDWebImageSwiftUI



class model: ObservableObject {
    
    let dbQueue: DatabaseQueue
    @Published var movies: [[Movie]] = [[],[],[],[],[],[],[],[],[],[],[],[]]
    
    var pit : AnyCancellable?
    
    
    
    init () {
        var config = Configuration()
        config.readonly = true
        let path = Bundle.main.path(forResource: "ClassicFilms", ofType: "sqlite")
        dbQueue = try! DatabaseQueue(path: path!, configuration: config)
        
        
        runf()
        
        //self.movies = [Movie(id: "kjhkj", title: "jhjhg")]
    }
    
    func runf () {
        
        pit = dbQueue.readPublisher { db in
            try! Movie.fetchAll(db)
        }.sink(receiveCompletion: { com in
            print("dcdcwdv")
        }, receiveValue: { movies in
            
            var movies1: [[Movie]] = [[],[],[],[],[],[],[],[],[],[],[],[]]
            for movie in movies {
                
                let index = (movie.year - 1900) / 10
                movies1[index].append(movie)
            }
            
            DispatchQueue.main.async {
                self.movies = movies1
            }
            
            
            print("__________")
        })
        
    }
    
    //private var playersCancellable: AnyCancellable?
    
    
}



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
            
        
        NavigationView{
        
        
        ScrollView {
            VStack {
                
                ForEach(1 ..< 8) { index in
                    
                    
                 
                    Text("19\(index * 10)s Movies").font(.body).bold().frame(maxWidth:.infinity, alignment: .leading)
                        .padding(.leading, 100).padding(.top, 70)//.focusable(false)
                    
                    
                    //  .frame(width: 500, height: 200, alignment: .leading)
                    
                    //Section(header: headerView(type: "19\(index * 10)")) {
                    
                    ScrollView(.horizontal) {

                        HStack {
                            Spacer().frame(width: 100)
                            ForEach(viewModel.movies[index]) { movie in
                                
                                MovieRow(movie: movie).padding(.top, 20).focusable(false)
                                
                            }
                            Spacer().frame(width: 100)
                        }.focusable(false)
                        // }
                        
                        //Text(movie.title)
                        
                        
                    }.focusable(false)//.padding(.horizontal, 50)
                }.focusable(false)
                
            }
            // .padding(.horizontal)
           //}//.navigationBarTitle("All Movies")
            
            
            
        }.edgesIgnoringSafeArea(.horizontal).focusable(false)
        
        }.tabItem {
        Text("All Movies")
        }
            
            Text("pit").tabItem {
                Text("Horor")
                }
            Text("comedy").tabItem {
                Text("Comedy")
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


//func headerView(type: String) -> some View{
//    return HStack {
//        Spacer()
//        Text("Section header \(type)")
//        Spacer()
//    }.padding(.all, 10).background(Color.blue)
//}


struct MovieRow: View {
    var movie: Movie
    @State var focused: Bool = false
    
    var body: some View {
        
        VStack{
            
            NavigationLink(destination: LazyView(MovieDetail(movie: movie))) {
            URLImage(url: URL(string: "https://image.tmdb.org/t/p/w400\(movie.posterURL)")!,
                     
                     failure: { error, _ in
                        Image("poster-placeholder").resizable()
                     },
                     content: {
                        $0
                            .resizable()
                            //.renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                        
                        //.clipped()
                        //
                     })
                .frame(width: 200.0, height: 300.0)
            
            }.buttonStyle(PlainButtonStyle())
            Text("\(movie.title)").frame(width: 200, height: 60)
        }
        
    }
}



struct PlayerOverLay: View {
    let action: () -> ()
    
    var body: some View {
        
        Text("dff")
        
        
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
