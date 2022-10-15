//
//  MovieRow.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 10/17/20.
//

import Foundation
import SwiftUI


enum Constants {
    
    static let imageHeight = imageWidth * 1.5
    static let textWidth = imageWidth
    
    #if os(iOS)
    static let imageWidth: CGFloat = 130
    static let textHeight: CGFloat = 30
    #elseif os(tvOS)
    static let textHeight: CGFloat = 30
    static let imageWidth: CGFloat = 260
    #endif
    
}

struct MovieItem: View {
    var movie: Movie
    //@State var focused: Bool = false
    @Namespace private var namespace
    @Environment(\.isFocused) var isFocused: Bool
  
    var corner: Bool = false
    @State var showDetails: Bool = false
    
    var body: some View {
        VStack{
            
            Button(action: {
                showDetails.toggle()
            }) {
                
            }.buttonStyle(CardButtonStyle())
            Text(isFocused ? "\(movie.title)" : "-").frame(width: Constants.textWidth, height: Constants.textHeight)
            NavigationLink(destination: LazyView(MovieDetail(movie: movie)), isActive: $showDetails){
            }.buttonStyle(PlainButtonStyle()).hidden().frame(width: 0, height: 0)
        }
        .onAppear {
            showDetails = false
        }
    }
    
}
