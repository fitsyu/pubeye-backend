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
    var video: Data?
}

// Report from user
final class FlatReport: SQLiteModel, Migration, Content {
    
    var id: Int?
    
    var what: String
    var who: String
    var when: String
    
    var lat: Double
    var lng: Double
    
    var img: Data
    var vid: Data?
    
    init(id: Int? = nil,
         what: String,
         who: String,
         when: String,
         
         lat: Double,
         lng: Double,
        
         img: Data,
         vid: Data?
        ) {
        
        self.id = id
        
        self.what = what
        self.who  = who
        self.when = when
        
        self.lat = lat
        self.lng = lng
        
        self.img = img
        self.vid = vid
    }
}

// Report for DB

final class LightReport: SQLiteModel, Migration, Content, Parameter {
    
    var id: Int?
    
    var what: String
    var who: String
    var when: String
    var whre: GeoLocation
    
    var how: LightProof
    
    init(id: Int? = nil,
         what: String,
         who: String,
         when: String,
         whre: GeoLocation,
         
         how: LightProof
        ) {
        
        self.id = id
        
        self.what = what
        self.who  = who
        self.when = when
        self.whre = whre
        
        self.how = how
    }
}

struct LightProof: Codable {
    
    var imagePath: String
    var videoPath: String
}
