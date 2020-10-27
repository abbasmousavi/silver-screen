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
        
        // NavigationView{
        
        ScrollView(.vertical) {
            VStack {
                
                ForEach(1 ..< 8) { index in
                    
                    if (!viewModel.movies[index].isEmpty){
                        // VStack {
                        Text("19\(index * 10)s Movies").font(.body).bold().frame(maxWidth:.infinity, alignment: .leading)
                            .padding(.leading, 100)
                        
                        MovieRow(movies: viewModel.movies[index])
                    }
                }
            }
        }.edgesIgnoringSafeArea(.horizontal)
    }
}
