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
            
            
            ScrollView(.vertical) {
                VStack {
                    
                    ForEach(1 ..< 8) { index in
                        
                        if (!viewModel.movies[index].isEmpty){
                        
                        Text("19\(index * 10)s Movies").font(.body).bold().frame(maxWidth:.infinity, alignment: .leading)
                            .padding(.leading, 100).padding(.top, 70)//.focusable(false)
                        
                        
                        //  .frame(width: 500, height: 200, alignment: .leading)
                        
                        //Section(header: headerView(type: "19\(index * 10)")) {
                        
                        ScrollView(.horizontal) {
                            
                            HStack {
                                Spacer().frame(width: 100)
                                ForEach(viewModel.movies[index]) { movie in
                                    
                                   MovieItem(movie: movie).padding(.top, 20).focusable(false)
                                    
                                }
                                Spacer().frame(width: 100)
                            }.focusable(false)
                            // }
                            
                            //Text(movie.title)
                            
                        
                        }.focusable(false)//.padding(.horizontal, 50)
                        }
                    }.focusable(false)
                    
                }
                // .padding(.horizontal)
                //}//.navigationBarTitle("All Movies")
                
                
                
            }.edgesIgnoringSafeArea(.horizontal).focusable(false)
        }
    }
}
