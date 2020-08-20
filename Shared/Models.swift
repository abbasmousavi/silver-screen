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
    var source: String
    var year: Int
    var tmdb: Int
    var archive_id: String
}

extension Movie: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    fileprivate enum Columns {
        static let name = Column(CodingKeys.title)
        
    }
}
