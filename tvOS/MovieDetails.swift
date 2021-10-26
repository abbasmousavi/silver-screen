//
//  MovieDetails.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 10/16/20.
//

import Foundation
import SwiftUI

struct MovieDetail: View {
    let movie: Movie
    @State private var isPresented = false
   
    init(movie: Movie) {
        
        self.movie = movie
    }
    
    
    
    var body: some View {

        HStack{
            
            
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(movie.posterURL)")) { image in
                                        image.resizable()
                
                    .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        Image("poster-placeholder")
                                    }
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

                }
                }
            }}
            .sheet(isPresented: $isPresented) {
               MoviePlayer(movie: movie)

            }.padding(.horizontal, 100).frame(height: 602)
           
            
            
    }
}
