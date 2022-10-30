//
//  MovieList.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 10/17/20.
//

import Foundation
import SwiftUI

struct MovieList: View {
    
    @ObservedObject var viewModel = model()
    private var movieType: MovieType?
    
    init(movieType: MovieType?) {
        
        self.movieType = movieType
        viewModel.query(type: movieType)
    }
    
    var body: some View {
        
        NavigationView{
            
            ScrollView {
                LazyVStack {
                    
                    ForEach(1 ..< 8) { index in
                        
                        if (!viewModel.movies[index].isEmpty){
                            VStack {
                                Text("19\(index * 10)s Movies").font(.body).bold().frame(maxWidth:.infinity, alignment: .leading)
                                    .padding(.leading, 20).padding(.top, 40)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        Spacer().frame(width: 20)
                                        ForEach(viewModel.movies[index]) { movie in
                                            
                                            MovieItem(movie: movie, corner: true)
                                        }
                                        Spacer().frame(width: 20)
                                    }
                                }.frame(height: Constants.imageHeight + Constants.textHeight + 5)
                            }
                        }
                    }
                }
            }.navigationBarTitle(Text("All Movies"))
        }
    }
}
