//
//  AboutPage.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 10/16/20.
//

import Foundation
import SwiftUI

fileprivate struct Assets {
    
    static func iaText() -> some View {
        Text("This product uses the Internet Archive (www.archive.org) as a streaming source for all movies. It only shows movies which the Internet Archive labels as in the public domain or which have an appropriate creativecommons.org license attached. Please contact the Internet Archive if there is any issue regarding the movies like content, quality, license and more. This product uses the Archive.org API but is not endorsed or certified by Archive.org.")
    }
    
    static func iaImage() -> some View {
        Image("internet-archive")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.primary)
    }
    
    static func tmdbImage() -> some View {
        Image("tmdb")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            
            .foregroundColor(.primary)
    }
    
    static func tmdbText() -> some View {
        
        Text("This product uses the Movie Database TMDb (www.themoviedb.org) as a source for any additional meta data about the movies found on the Internet Archive. This includes movie posters, images, title, year, description and others. Please contact the Movie Database if there is any issue regarding the movie meta data. This product uses the TMDb API but is not endorsed or certified by TMDb.")
    }
    
}

#if os(tvOS)

struct AboutPage: View {
    
    var body: some View {
        
        VStack {
            HStack{
                
                Assets.iaImage().frame(width: 200)
                Assets.iaText()
                
            }.padding(.bottom)
            
            HStack{
                
                Assets.tmdbImage().frame(width: 200)
                Assets.tmdbText()
            }
        }.padding(.horizontal, 200)
    }
}

#elseif os(iOS)

struct AboutPage: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        GeometryReader { g in
            ScrollView(.vertical, showsIndicators: false){
                
                VStack {
                    switch horizontalSizeClass {
                    case .compact:
                        Assets.iaImage().frame(width: 150).padding(.bottom)
                        Assets.iaText().padding(.bottom)
                        
                        Assets.tmdbImage().frame(width: 150).padding(.bottom)
                        Assets.tmdbText().padding(.bottom)
                    default:
                        
                        HStack{
                            
                            Assets.iaImage().frame(width: 200)
                            Assets.iaText()
                            
                        }.padding(.bottom)
                        
                        HStack{
                            
                            Assets.tmdbImage().frame(width: 200)
                            Assets.tmdbText()
                        }
                    }
                }.padding(.all, horizontalSizeClass == .compact ? g.size.width * 0.1 : g.size.width * 0.25)
            }
        }
    }
}
#endif
