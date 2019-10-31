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
    var whre: GeoLocation
    
    var how: Proof
//    var video: URL
    
    init(id: Int? = nil,
         what: String,
         who: String,
         when: String,
         whre: GeoLocation,
         
         how: Proof
        ) {
        
        self.id = id
        
        self.what = what
        self.who  = who
        self.when = when
        self.whre = whre
        
        self.how = how
    }
}

extension Report: Migration { }

extension Report: Content { }

extension Report: Parameter { }

struct GeoLocation: Codable {
    var latitude: Double
    var longitude: Double
}

struct Proof: Codable {
    var photo: Data
}
