//
//  MovieRow.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 10/24/20.
//

import Foundation
import SwiftUI


//enum Constants {
//
//    static let imageHeight = imageWidth * 1.5
//    static let textWidth = imageWidth
//
//    #if os(iOS)
//    static let imageWidth: CGFloat = 130
//    static let textHeight: CGFloat = 30
//    #elseif os(tvOS)
//    static let textHeight: CGFloat = 30
//    static let imageWidth: CGFloat = 260
//    #endif
//
//}

struct MovieRow: View {
    
    var movies: [Movie]
    //@Namespace private var namespace
    //@Environment(\.isFocused) var isFocused: Bool
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
//                        .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                   .focused($focusedField, equals: "https://image.tmdb.org/t/p/w400\(movie.posterURL)")
                    
                    
                    Text("\(movie.title)")
                       .frame(width: Constants.textWidth, height: Constants.textHeight)
                       .padding(.top, focusedField == "https://image.tmdb.org/t/p/w400\(movie.posterURL)" ? 0 : -20)
                }
                
            }.padding(.top, 30).padding(.horizontal, 100)//.frame(height: 500)
            NavigationLink("", destination: LazyView(MovieDetail(movie: selectedMovie)), isActive: $showDetails).hidden()
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


////                URLImage(url: URL(string: "https://image.tmdb.org/t/p/w400\(movie.posterURL)")!,
////
////                         failure: { error, _ in
////                            Image("poster-placeholder").resizable()//.frame(width: Constants.imageWidth, height: Constants.imageHeight)
////                         },
////                         content: {
////                            $0
////                                .resizable()
////                                .aspectRatio(contentMode: .fill)
////                                .cornerRadius(corner ? 10 : 0)
////
////                            //.clipped()
////                            //
////                         })
////



//NavigationLink(destination: LazyView(MovieDetail(movie: movie)), isActive: $showDetails){
//}.buttonStyle(PlainButtonStyle()).hidden()
//struct MyButtonStyle: CardButtonStyle {
//    @Environment(\.isFocused) var focused: Bool
//
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .onChange(of: focused) { newValue in
//                // do whatever based on focus
//            }
//    }
//}
