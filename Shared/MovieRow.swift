//
//  MovieRow.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 10/24/20.
//

import Foundation
import SwiftUI

struct MovieRow: View {
    
    var movies: [Movie]
    @State var showDetails: Bool = false
    @State var selectedMovie: Movie = Movie.empty()
    
    var rows: [GridItem] = [.init(.fixed(Constants.imageHeight)), .init(.fixed(Constants.textHeight))]
    
    @FocusState private var focusedField: String?
    
    var body: some View {
        
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .top){
                ForEach(movies) { movie in
                    Button(action: {
                        self.selectedMovie = movie
                        print(selectedMovie)
                        showDetails.toggle()
                        
                    }) {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w400\(movie.posterURL)")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image("poster-placeholder").resizable()
                        }
                        .frame(width: Constants.imageWidth, height: Constants.imageHeight)

                    }.buttonStyle(CardButtonStyle())
                        .focused($focusedField, equals: "https://image.tmdb.org/t/p/w400\(movie.posterURL)")
                    
                    Text("\(movie.title)")
                        .frame(width: Constants.textWidth, height: Constants.textHeight)
                        .padding(.top, focusedField == "https://image.tmdb.org/t/p/w400\(movie.posterURL)" ? 0 : -20)
                }
            }.padding(.top, 30).padding(.horizontal, 100)
            
            NavigationLink("", destination: LazyView(MovieDetail(movie: selectedMovie)), isActive: $showDetails).hidden()

        }
    }
}
              
