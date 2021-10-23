//
//  File.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 8/10/20.
//

import Combine
import GRDB
import Foundation

enum MovieType: String {
    case noir = "Film_Noir"
    case comedy = "Comedy_Films"
    case horor = "SciFi_Horror"
}

struct Movie: Identifiable {
    
    var id: Int
    var title: String
    var description: String
    var posterURL: String
    var backdropURL: String
    var runtime: Int
    var source: String
    var year: Int
    var tmdb: Int
    var archive_id: String
    var license: String
    var rating: Float
    var collection: String
    
    
    var licenseString: String  {
        
        if license.contains("publicdomain") {
            return "Public Domain"
        } else {
            return "Creative Commons"
        }
    }
    
    static func empty() -> Movie {
        Movie(id: 0, title: "", description: "", posterURL: "", backdropURL: "", runtime: 0, source: "", year: 0, tmdb: 0, archive_id: "", license: "", rating: 0.0, collection: "")
    }
}

extension Movie: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    fileprivate enum Columns {
        static let name = Column(CodingKeys.title)
        static let collection = Column(CodingKeys.collection)
        
    }
}


class model: ObservableObject {
    
    let dbQueue: DatabaseQueue
    @Published var movies: [[Movie]] = [[],[],[],[],[],[],[],[],[],[],[],[]]
    
    var pit : AnyCancellable?
    
    
    
    init () {
        var config = Configuration()
        config.readonly = true
        let path = Bundle.main.path(forResource: "ClassicFilms", ofType: "sqlite")
        dbQueue = try! DatabaseQueue(path: path!, configuration: config)
        
        
        //query()
        
        //self.movies = [Movie(id: "kjhkj", title: "jhjhg")]
    }
    
    func query (type: MovieType? = nil) {
        
        pit = dbQueue.readPublisher { db -> [Movie] in
            
            if let type = type {
                return try! Movie.filter(Movie.Columns.collection == type.rawValue).fetchAll(db)
                
           } else {
            return try! Movie.fetchAll(db)
            }
        }.sink(receiveCompletion: { com in
            print("dcdcwdv")
        }, receiveValue: { movies in
            
            var movies1: [[Movie]] = [[],[],[],[],[],[],[],[],[],[],[],[]]
            for movie in movies {
                
                let index = (movie.year - 1900) / 10
                movies1[index].append(movie)
            }
            
            DispatchQueue.main.async {
                self.movies = movies1
            }
            
            
            print("__________")
        })
        
    }
    
    //private var playersCancellable: AnyCancellable?
    
    
}
