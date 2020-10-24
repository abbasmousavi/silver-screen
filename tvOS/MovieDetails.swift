//
//  MovieDetails.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 10/16/20.
//

import Foundation
import SwiftUI
import URLImage

struct MovieDetail: View {
    let movie: Movie
    @State private var isPresented = false
    @Namespace private var namespace
    @Environment(\.resetFocus) var resetFocus

    
    
    init(movie: Movie) {
        
        self.movie = movie
    }
    
    
    
    var body: some View {

        HStack{
            
            URLImage(url: URL(string: "https://image.tmdb.org/t/p/original\(movie.posterURL)")!,
                     failure: { error, _ in
                        Image("poster-placeholder")
                     },
                     content: {
                        $0.resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(20)
                     })
                .frame(width: 400.0, height: 600.0)
            
            VStack {
                
                HStack{
                    Text(movie.title).font(.largeTitle)
                    Spacer()
                    
                }.padding(.bottom)
                
                HStack{

                    Text(String(format: "%d", movie.year))
                    Spacer(minLength: 20)
                    Text("\(movie.runtime / 60) Min")
                    Spacer(minLength: 20)
                    Text("TMDB Rating: " + String(format: "%.1f", movie.rating))
                    Spacer(minLength: 20)
                    Text(movie.licenseString)

                } .padding(.bottom, 50)

                HStack{
                Text(movie.description)
                }
                
                Spacer()
                
                HStack{
                Button("Play") {
                    self.isPresented.toggle()
                    resetFocus(in: namespace)
                }//.prefersDefaultFocus(in: namespace)
                    
                }
                
                
                // .fullScreenCover(isPresented: $isPresented, content: MoviePlayer(movie: movie))
            }}
            .sheet(isPresented: $isPresented) {
               // MoviePlayer(movie: movie)
                AVPlayerView(videoURL: URL(string: "https://archive.org/download/\(movie.archive_id)/\(movie.source)")!).ignoresSafeArea()
            }.padding(.horizontal, 100).frame(height: 602)
           
            
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
