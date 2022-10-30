//
//  MovieDetails.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 10/16/20.
//

import Foundation
import SwiftUI
import AVKit

struct MovieDetail: View {
    let movie: Movie
    @State private var isPresented = false
    
    init(movie: Movie) {
        
        self.movie = movie
    }
    
    var body: some View {
        
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
            }.padding(.horizontal)
            
        }
        .fullScreenCover(isPresented: $isPresented) {
            
            AVPlayerView(videoURL: URL(string: "https://archive.org/download/\(movie.archive_id)/\(movie.source)")!).ignoresSafeArea()
        }
    }
}




