//
//  File.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 8/10/20.
//

import GRDB

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
    
    
    var licenseString: String  {
        
        if license.contains("publicdomain") {
            return "Public Domain"
        } else {
            return "Creative Commons"
        }
    }
}

extension Movie: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    fileprivate enum Columns {
        static let name = Column(CodingKeys.title)
        
    }
}
