//
//  ReportController.swift
//  App
//
//  Created by Fitsyu  on 31/10/19.
//

import Vapor

final class ReportController {
    
    func create(_ req: Request) throws -> Future<HTTPStatus> {
        
        
        return try req.content.decode(Report.self).map(to: HTTPStatus.self) { report in
            
            _ = report.save(on: req)
            
            return .created
        }
    }
    
    func index(_ req: Request) throws -> Future<[Report]> {
        let reports = Report.query(on: req).all()
        return reports
    }
}
