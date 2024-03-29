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
            
            return .created
        }
    }
    
    func index(_ req: Request) throws -> Future<[Report]> {
        let reports = Report.query(on: req).sort(\.fluentID, .descending).all()
        return reports
    }
    
    func upload(_ req: Request) throws -> Future<HTTPStatus> {
        
        return try req.content.decode(FlatReport.self).map(to: HTTPStatus.self) { report in
            
            print(report.what)
            
            if let videoBytesCount = report.vid?.count {
                let bf = ByteCountFormatter()
                bf.allowedUnits = .useMB
                let size = bf.string(fromByteCount: Int64(videoBytesCount))
                print(size)
            }
            
            // --
            
            let directory = DirectoryConfig.detect()
            let workPath = directory.workDir
            
            let id = UUID().uuidString
            
            let imageName =  id + ".jpg"
            let imageFolder = "Public/images"
            let imageUrl = URL(fileURLWithPath: workPath)
                .appendingPathComponent(imageFolder, isDirectory: true)
                .appendingPathComponent(imageName)
            
            
            var bool1: ObjCBool = true
            if !FileManager.default.fileExists(atPath: imageFolder, isDirectory: &bool1) {
                
                do {
                    
                    print("trying to create image directory")
                    
                    let imageFolderURL = URL(fileURLWithPath: workPath).appendingPathComponent(imageFolder, isDirectory: true)
                    try FileManager.default.createDirectory( at: imageFolderURL,
                                                             withIntermediateDirectories: false, attributes: nil)
                    
                } catch {
                    print(error)
                }
            }

            print("writing image to \(imageUrl.path)")
            FileManager.default.createFile(atPath: imageUrl.path, contents: report.img, attributes: nil)
            
            
            
            var videoUrl: URL? = nil
            var videoName = ""
            
            if let videoData = report.vid {
                
   
                
                
                videoName = id + ".mov"
                let videoFolder = "Public/videos"
                videoUrl = URL(fileURLWithPath: workPath)
                .appendingPathComponent(videoFolder, isDirectory: true)
                .appendingPathComponent(videoName)
                
                
                var bool2: ObjCBool = true
                if !FileManager.default.fileExists(atPath: videoFolder, isDirectory: &bool2) {
                    
                    do {
                    
                        print("trying to create video directory")
                        
                        let videoFolderURL = URL(fileURLWithPath: workPath).appendingPathComponent(videoFolder, isDirectory: true)
                        try FileManager.default.createDirectory( at: videoFolderURL,
                        withIntermediateDirectories: false, attributes: nil)
                        
                    } catch {
                        print(error)
                    }
                }
                
                print("writing video to \(videoUrl!.path)")
                FileManager.default.createFile(atPath: videoUrl!.path, contents: videoData, attributes: nil)
            }
            
            
            //
            
            let lightReport = LightReport(what: report.what,
                                          who: report.who,
                                          when: report.when,
                                          whre: GeoLocation(latitude: report.lat,
                                                            longitude: report.lng),
                                          how: LightProof(imagePath: imageName,
                                                          videoPath: videoName))
            
            
            // save
            
            print("saving light report")
            _ = lightReport.save(on: req)
            
            
            return .created
        }
    }

}
