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
        
      //  VStack(spacing: 5){
            
            //NavigationLink(destination: LazyView(MovieDetail(movie: movie))) {
//            Button(action: {
//                // your action here
//            }) {
          //      Image("poster-placeholder").resizable().frame(width: Constants.imageWidth, height: Constants.imageHeight)
            
                
//                URLImage(url: URL(string: "https://image.tmdb.org/t/p/w400\(movie.posterURL)")!,
//                                 options: URLImageOptions(
////                                    identifier: id.uuidString,      // Custom identifier
////                                    expireAfter: 300.0,             // Expire after 5 minutes
//                                    cachePolicy: .returnCacheElseLoad(cacheDelay: nil, downloadDelay: 0.25) // Return cached image or download after delay
//                                 ),
//                                 empty: {
//                                    Image("poster-placeholder").resizable()
//                                 },
//                                 inProgress: { progress -> Image in  // Display progress
//                                    Image("poster-placeholder").resizable()
//                                 },
//                                 failure: { error, retry in         // Display error and retry
//                                    Image("poster-placeholder").resizable()
//                                 },
//                                 content: { image in                // Content view
//                                    image
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                 }).frame(width: Constants.imageWidth, height: Constants.imageHeight)
//                URLImage(url: URL(string: "https://image.tmdb.org/t/p/w400\(movie.posterURL)")!,
//
//                         failure: { error, _ in
//                            Image("poster-placeholder").resizable()
//                         },
//                         content: {
//                            $0
//                                .resizable()
//                                //.renderingMode(.original)
//                                .aspectRatio(contentMode: .fill)
//                                .cornerRadius(corner ? 10 : 0)
//
//                            .clipped()
//                            //
//                         })
                //Image("poster-placeholder").resizable().frame(width: Constants.imageWidth, height: Constants.imageHeight)


           // }.buttonStyle(CardButtonStyle())
           // Text("\(movie.title)").frame(width: Constants.textWidth, height: Constants.textHeight)
       // }//.frame(width: Constants.textWidth, height: Constants.textHeight + Constants.imageHeight)
        
 //   }

