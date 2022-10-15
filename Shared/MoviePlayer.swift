//
//  MoviePlayer.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 10/16/20.
//

import Foundation
import SwiftUI
import AVKit
import Combine


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
            
            VideoPlayer(player: player) {
        }.onAppear {
            player.play()
        }.onDisappear{
            player.pause()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

class PlayerItemObserver: ObservableObject {
    
    @Published var currentStatus: AVPlayer.TimeControlStatus?
    private var itemObservation: AnyCancellable?
    
    init(player: AVPlayer) {
        
        itemObservation = player.publisher(for: \.timeControlStatus).sink { newStatus in
            print(newStatus)
            self.currentStatus = newStatus
        }
    }
}
