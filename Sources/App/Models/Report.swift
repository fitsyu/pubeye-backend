//
//  Report.swift
//  App
//
//  Created by Fitsyu  on 31/10/19.
//

import FluentSQLite
import Vapor

final class Report: SQLiteModel {
    
    var id: Int?
    
    var what: String
    var who: String
    var when: String
    var `where`: GeoLocation
//    var photo: URL
//    var video: URL
    
    init(id: Int? = nil,
         what: String,
         who: String,
         when: String,
         `where`: GeoLocation
        ) {
        
        self.id = id
        
        self.what = what
        self.who  = who
        self.when = when
        self.where = `where`
    }
}

extension Report: Migration { }

extension Report: Content { }

extension Report: Parameter { }

struct GeoLocation: Codable {
    var latitude: Double
    var longitude: Double
}
