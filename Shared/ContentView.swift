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
import KingfisherSwiftUI

struct Movie: Identifiable {
    
    var id: String?
    var title: String
    var description: String
    var poster: String
    var source: String
}

extension Movie: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    fileprivate enum Columns {
        static let name = Column(CodingKeys.title)
        
    }
}

class model: ObservableObject {
    
    let dbQueue: DatabaseQueue
    @Published var movies: [Movie] = []
    
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
        }, receiveValue: { movie in
            self.movies = movie
            print("__________")
        })
        
    }
    
    //private var playersCancellable: AnyCancellable?
    
    
}



struct ContentView: View {
    
    @ObservedObject var viewModel = model()
    
    let columns = [
        GridItem(.adaptive(minimum: 320))
    ]
    
    
    var body: some View {
        NavigationView{
            
            
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.movies) { movie in
                        MovieRow(movie: movie)
                        //Text(movie.title)
                    }
                }
                .padding(.horizontal)
            }.navigationBarTitle("All Movies")
            
            
            
        }
    }
}

struct MovieRow: View {
    var movie: Movie
    
    var body: some View {
        
        VStack{
            
            KFImage(URL(string: "https://image.tmdb.org/t/p/original\(movie.poster)")!).resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 200)
            NavigationLink(destination: LazyView(MovieDetail(movie: movie))) {
                Text("\(movie.title)")
            }
        }
    }
}

struct MovieDetail: View {
    let movie: Movie
    
    let player: AVPlayer
    @ObservedObject  var playerObserver: PlayerItemObserver
    
    init(movie: Movie) {
        
        self.movie = movie
        self.player = AVPlayer(url:  URL(string: "https://archive.org/download/\(movie.id!)/\(movie.source)")!)
        self.player.allowsExternalPlayback = true
        self.playerObserver =  PlayerItemObserver(player: player)
    }
    
    
    
    var body: some View {
        
        
        
        
        
        ZStack {
            
            switch playerObserver.currentStatus {
            case nil:
                Text("nothing is here")
            case .waitingToPlayAtSpecifiedRate:
                ProgressView()
                
            case .playing, .paused:
                //Text("playing")
                VideoPlayer(player: player)
                
                
            case .some(_):
                Text("ddgdgdgdgdgdgdgdgdgdg")
            }
        }.navigationBarTitle(movie.title)
        .onAppear {
            player.play()
        }.onDisappear{
            player.pause()
        }
        
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
