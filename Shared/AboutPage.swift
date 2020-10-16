//
//  AboutPage.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 10/16/20.
//

import Foundation
import SwiftUI


struct AboutPage: View {
    
    var body: some View {
        
        VStack {
            HStack{
                Image("internet-archive")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .foregroundColor(.accentColor)
                
                Text("This product uses the Internet Archive (www.archive.org) as a streaming source for all movies. It only shows movies which the Internet Archive labels as in the public domain or which have an appropriate creativecommons.org license attached. Please contact the Internet Archive if there is any issue regarding the movies like content, quality, license and more. This product uses the Archive.org API but is not endorsed or certified by Archive.org.")
            }.padding(.bottom)
            
            HStack{
                Image("tmdb")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .foregroundColor(.accentColor)
                
                Text("This product uses the Movie Database TMDb (www.themoviedb.org) as a source for any additional meta data about the movies found on the Internet Archive. This includes movie posters, images, title, year, description and others. Please contact the Movie Database if there is any issue regarding the movie meta data. This product uses the TMDb API but is not endorsed or certified by TMDb.")
            }
        }
    }
}
