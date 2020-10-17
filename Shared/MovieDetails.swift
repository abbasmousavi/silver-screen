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
    //@Namespace private var namespace
    
    
    init(movie: Movie) {
        
        self.movie = movie
    }
    
    
    
    var body: some View {
        
        
        //        ZStack {
        //
        //            KFImage(URL(string: "https://image.tmdb.org/t/p/original\(movie.backdropURL)")!).resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all).blur(radius: 10)
        
        
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
                Text(movie.description)
                    .padding([.bottom])
                }
                
                HStack{
                    Text("Year: ").bold()
                    Spacer()
                    Text(String(format: "%d", movie.year))
                }//.padding(.bottom, 1)
                
                HStack{
                    Text("Duration: ").bold()
                    Spacer()
                    Text("\(movie.runtime / 60) Min")
                }//.padding(.bottom, 1)
                
                HStack{
                    Text("Rating: ").bold()
                    Spacer()
                    Text(String(format: "%.1f", movie.rating))
                }//.padding(.bottom, 1)
                
                HStack{
                    Text("License: ").bold()
                    Spacer()
                    Text(movie.licenseString)
                }//.padding(.bottom, 1)
                
                Spacer()
                
                HStack{
                Button("Play") {
                    self.isPresented.toggle()
                }
                    
                }
                
                
                // .fullScreenCover(isPresented: $isPresented, content: MoviePlayer(movie: movie))
            }}
            .sheet(isPresented: $isPresented) {
                MoviePlayer(movie: movie)
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
