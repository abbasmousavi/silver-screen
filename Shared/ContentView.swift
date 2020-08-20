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



class model: ObservableObject {
    
    let dbQueue: DatabaseQueue
    @Published var movies: [[Movie]] = [[],[],[],[],[],[],[],[],[],[],[],[]]
    
    var pit : AnyCancellable?
    
    
    
    init () {
        let path = Bundle.main.path(forResource: "ClassicFilms", ofType: "sqlite")
        dbQueue = try! DatabaseQueue(path: path!)
        
        
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
            
            
            
            self.movies = movies1
            print("__________")
        })
        
    }
    
    //private var playersCancellable: AnyCancellable?
    
    
}



struct ContentView: View {
    
    @ObservedObject var viewModel = model()
    
    let columns = [
        GridItem(.flexible(minimum: 0, maximum: .infinity)),
        GridItem(.flexible(minimum: 0, maximum: .infinity))
    ]
    
    
    var body: some View {
        NavigationView{
            
            
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20, pinnedViews: [.sectionHeaders]) {
                    
                    ForEach(1 ..< 8) { index in
                        
                        Section(header: headerView(type: "19\(index * 10)")) {
                            ForEach(viewModel.movies[index]) { movie in
                                MovieRow(movie: movie)
                                //Text(movie.title)
                            }
                        }
                    }
                  
                }
                .padding(.horizontal)
            }//.navigationBarTitle("All Movies")
            
            
            
        }
    }
}

func headerView(type: String) -> some View{
        return HStack {
            Spacer()
            Text("Section header \(type)")
            Spacer()
        }.padding(.all, 10).background(Color.blue)
    }


struct MovieRow: View {
    var movie: Movie
    
    var body: some View {
        
        VStack{
            
            URLImage(URL(string: "https://image.tmdb.org/t/p/w400\(movie.posterURL)")!, incremental: true){ proxy in
                proxy.image
                    .resizable()                     // Make image resizable
                    .aspectRatio(contentMode: .fit) // Fill the frame
                    .clipped()                       // Clip overlaping parts
                }
                .frame(width: 150.0, height: 250.0)
                
            NavigationLink(destination: LazyView(MovieDetail(movie: movie))) {
                Text("\(movie.title)").frame(width: 300, height: 50)
            }
        }
    }
}



struct PlayerOverLay: View {
    let action: () -> ()
    
    var body: some View {
        
        Text("dff")
    
       
    }

}



struct MoviePlayer: View {
    let movie: Movie
    
    let player: AVPlayer
    @ObservedObject  var playerObserver: PlayerItemObserver
    @Environment(\.presentationMode) var presentationMode
    
    init(movie: Movie) {
        
        self.movie = movie
        self.player = AVPlayer(url:  URL(string: "https://archive.org/download/\(movie.archive_id)/\(movie.source)")!)
        self.player.allowsExternalPlayback = true
        self.playerObserver =  PlayerItemObserver(player: player)
    }
    
    var body: some View {
        
        VStack {
            
            VideoPlayer(player: player) {
                
//                Button("Close"){
//                    self.presentationMode.wrappedValue.dismiss()
//                }
                
            }
            
                            
                           
        }.onAppear {
            player.play()
          }.onDisappear{
            player.pause()
          }//.frame(maxWidth: .infinity, maxHeight: .infinity)
       
        .edgesIgnoringSafeArea(.all)
    }
}
    


struct MovieDetail: View {
    let movie: Movie
    @State private var isPresented = false
  
    
    init(movie: Movie) {
        
        self.movie = movie
    }
    
    
    
    var body: some View {
        
        
//        ZStack {
//
//            KFImage(URL(string: "https://image.tmdb.org/t/p/original\(movie.backdropURL)")!).resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all).blur(radius: 10)
        
        
        VStack {
            URLImage(URL(string: "https://image.tmdb.org/t/p/original\(movie.posterURL)")!, incremental: true){ proxy in
                proxy.image
                    .resizable()                     // Make image resizable
                    .aspectRatio(contentMode: .fit) // Fill the frame
                    .clipped()                       // Clip overlaping parts
                }
                .frame(width: 250.0, height: 350.0)
            
            
            
         
            Text(movie.description).padding()
            Text("\(movie.year)").padding()
            
            Button("Play") {
                self.isPresented.toggle()
            }
            
          
                   // .fullScreenCover(isPresented: $isPresented, content: MoviePlayer(movie: movie))
        }
        .fullScreenCover(isPresented: $isPresented) {
            MoviePlayer(movie: movie)
        }.navigationBarTitle(movie.title)
        
        
//        }
        
            
     
            
          //  PresentationButton(Text("Play"),destination: MoviePlayer(movie: movie))
           
            
            
            
//            switch playerObserver.currentStatus {
//            case nil:
//                Text("nothing is here")
//            case .waitingToPlayAtSpecifiedRate:
//                ProgressView()
//
//            case .playing, .paused:
//                //Text("playing")
//
//
//
//
//
//            case .some(_):
//                Text("ddgdgdgdgdgdgdgdgdgdg")
//            }
//        }.navigationBarTitle(movie.title)
        
        
        //        Text("https://archive.org/download/\(movie.id!)/\(movie.source)").onReceive(playerObserver.$currentStatus) { output in
        //            switch output {
        //                            case nil:
        //                                Text("nothing is here")
        //                            case .waitingToPlayAtSpecifiedRate:
        //                                Text("waiting")
        //                            case .paused:
        //                                Text("paused")
        //                            case .playing:
        //                                Text("playing")
        //            case .some(_):
        //                Text("I dont know")
        //            }
        //       }
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


class PlayerItemObserver: ObservableObject {
    
    @Published var currentStatus: AVPlayer.TimeControlStatus?
    private var itemObservation: AnyCancellable?
    
    init(player: AVPlayer) {
        
        itemObservation = player.publisher(for: \.timeControlStatus).sink { newStatus in
            print(newStatus.rawValue)
            self.currentStatus = newStatus
        }
        
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
