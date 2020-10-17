//
//  MovieRow.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 10/17/20.
//

import Foundation
import SwiftUI
import URLImage

struct MovieRow: View {
    var movie: Movie
    @State var focused: Bool = false
    
    var body: some View {
        
        VStack{
            
            NavigationLink(destination: LazyView(MovieDetail(movie: movie))) {
                URLImage(url: URL(string: "https://image.tmdb.org/t/p/w400\(movie.posterURL)")!,
                         
                         failure: { error, _ in
                            Image("poster-placeholder").resizable()
                         },
                         content: {
                            $0
                                .resizable()
                                //.renderingMode(.original)
                                .aspectRatio(contentMode: .fill)
                            
                            //.clipped()
                            //
                         })
                    .frame(width: 200.0, height: 300.0)
                
            }.buttonStyle(PlainButtonStyle())
            Text("\(movie.title)").frame(width: 200, height: 60)
        }
        
    }
}
