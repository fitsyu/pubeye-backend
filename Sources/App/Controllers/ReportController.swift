//
//  ReportController.swift
//  App
//
//  Created by Fitsyu  on 31/10/19.
//

import Vapor
//import AppKit

final class ReportController {
    
    
    
    @available(OSX 10.12, *)
    func create(_ req: Request) throws -> Future<HTTPStatus> {
        
        
        return try req.content.decode(Report.self).map(to: HTTPStatus.self) { report in
            
            _ = report.save(on: req)
            
//            let tempDir = FileManager.default.temporaryDirectory
//            
//            if let img = NSImage(data: report.how.photo) {
//                print(img)
//                
//                let tempImgPath = tempDir.appendingPathComponent("img-\(report.id ?? 00).jpeg")
//                print("will be saved to \(tempImgPath.path)")
//                
//                FileManager.default.createFile(atPath: tempImgPath.path,
//                                               contents: report.how.photo,
//                                               attributes: nil)
//                
//                let content = try? FileManager.default.contentsOfDirectory(atPath: tempDir.path)
//                print(content)
//                
//                
//                print("creating light report")
//                let lightReport = LightReport(id: report.id,
//                                              what: report.what,
//                                              who: report.who,
//                                              when: report.when,
//                                              whre: report.whre,
//                                              how: LightProof(photo: tempImgPath))
//                
//                lightReport.save(on: req)
//                
//            } else {
//                print("cant save image")
//            }
//            
            
            return .created
        }
    }
    
    func index(_ req: Request) throws -> Future<[Report]> {
        let reports = Report.query(on: req).all()
        return reports
    }
    
    func upload(_ req: Request) throws -> Future<HTTPStatus> {
        
        return try req.content.decode(FlatReport.self).map(to: HTTPStatus.self) { flatReport in
            
            print(flatReport.what)
            
            if let videoBytesCount = flatReport.vid?.count {
                let bf = ByteCountFormatter()
                bf.allowedUnits = .useMB
                let size = bf.string(fromByteCount: Int64(videoBytesCount))
                print(size)
            }
            
//            _ = flatReport.save(on: req)
            
            let report = Report(what: flatReport.what,
                                who: flatReport.who,
                                when: flatReport.when,
                                whre: GeoLocation(latitude: flatReport.lat,
                                                  longitude: flatReport.lng),
                                how: Proof(photo: flatReport.img,
                                           video: flatReport.vid))
            
            _ = report.save(on: req)
            
            return .created
        }
    }

}
