//
//  MovieDetails.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 10/16/20.
//

import Foundation
import SwiftUI
import URLImage
import AVKit

struct MovieDetail: View {
    let movie: Movie
    @State private var isPresented = false
    //@Namespace private var namespace
    
    
    init(movie: Movie) {
        
        self.movie = movie
    }
    
    
    
    var body: some View {
        
        
        //        ZStack {
        //
        //            KFImage(URL(string: "https://image.tmdb.org/t/p/original\(movie.backdropURL)")!).resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all).blur(radius: 10)
        
        ScrollView{
        VStack{
            
            URLImage(url: URL(string: "https://image.tmdb.org/t/p/original\(movie.posterURL)")!,
                     failure: { error, _ in
                        Image("poster-placeholder")
                     },
                     content: {
                        $0.resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(10)
                     })
                .frame(width: 200.0, height: 300.0)
                .padding(.bottom)
            

                
                HStack{
                    Text(movie.title).font(.largeTitle)
                   
                    
                }.padding(.bottom)
                
                HStack{

                    Text(String(format: "%d", movie.year))
                    Spacer()
                    Text("\(movie.runtime / 60) Min")
                    Spacer()
                    Text("Rating: " + String(format: "%.1f", movie.rating))
                    Spacer()
                    Text(movie.licenseString)

                }.font(.caption).padding([.bottom, .leading, .trailing], 30)
            
            Button(action: {
                self.isPresented.toggle()
            }) {HStack{Image(systemName: "play")
                Text("Play")}}.padding().background(Color(UIColor.label)).cornerRadius(5)
            .padding(.bottom, 30)

                HStack{
                Text(movie.description)
                }.padding(.bottom)
                
                
                
               
                // .fullScreenCover(isPresented: $isPresented, content: MoviePlayer(movie: movie))
            }.padding(.horizontal)
            
        }
            .fullScreenCover(isPresented: $isPresented) {
                //MoviePlayer(movie: movie)
                AVPlayerView(videoURL: URL(string: "https://archive.org/download/\(movie.archive_id)/\(movie.source)")!).ignoresSafeArea()
            }//.padding(.horizontal, 100).frame(height: 602)
            
            //.focusScope(namespace)//.navigationBarTitle(movie.title)
    }
}
        
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
        


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


struct AVPlayerView: UIViewControllerRepresentable {
    
   // typealias UIViewControllerType = <#type#>
    

    var videoURL: URL

    private var player: AVPlayer {
        
        return AVPlayer(url: URL(string: "https://stream1.eu.ir-cdn.xyz/movies/p/palm_springs_2020/720p/palm_springs_2020_1442_720p.m3u8")!)//videoURL)
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {
        if playerController.player == nil {
            playerController.player = player
            let subtitleFile = Bundle.main.path(forResource: "persian", ofType: "vtt")
            let subtitleURL = URL(fileURLWithPath: subtitleFile!)
            playerController.addSubtitles().open(fileFromLocal: subtitleURL)
        }
        
        playerController.player?.play()
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        var pit = AVPlayerViewController()
        pit.allowsPictureInPicturePlayback = true
        return pit
    }
}
