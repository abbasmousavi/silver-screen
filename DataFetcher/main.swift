




//
//  main.swift
//  DataFetcher
//
//  Created by Abbas Mousavi on 8/10/20.
//

import Foundation
import GRDB
import Combine


let path = "/Users/abbasmousavi/Desktop/ClassicFilms1.sqlite"
let dbQueue = try! DatabaseQueue(path: path)

//var pit : AnyCancellable?
//var movies = [Movie]()
//pit = dbQueue.readPublisher { db in
//    try! Movie.fetchAll(db)
//}.map {
//
//}






//.sink(receiveCompletion: { com in
//    print("dcdcwdv")
//}, receiveValue: { movies in
//
//
//})





var movies = [Movie]()
try dbQueue.read { db in
    // Place?
 movies = try Movie.fetchAll(db)
}

    let pit = movies.publisher
        .flatMap(maxPublishers: .max(1)) { movie -> AnyPublisher<TopLevel, Error> in
            print(movie.id, movie.tmdb)
            return details(for: movie.tmdb)
        }.sink(receiveCompletion: { completion in
            
            print(completion)

            }) { post in
           
            
            
            try! dbQueue.write { db in
                
                try db.execute(
                        sql: "UPDATE MOVIE SET backdropURL = :back, posterURL = :poster WHERE tmdb = :id",
                    arguments: ["back": post.backdropPath ?? "", "id": post.id, "poster": post.posterPath ?? ""])
                    }
            print(post.id)
            }
            
            
            
            







RunLoop.main.run()


func details(for id: Int) -> AnyPublisher<TopLevel, Error> {
    let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=1728d158d94f52e65e1a31d4e8bd91ae")!
    return URLSession.shared.dataTaskPublisher(for: url)
        .mapError { $0 as Error }
        .map { $0.data }
        .decode(type: TopLevel.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}
