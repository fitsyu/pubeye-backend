import Vapor
//import AppKit

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
//    // Basic "It works" example
//    router.get { req in
//        return "It works!"
//    }
    
//    // Basic "Hello, world!" example
//    router.get("hello") { req -> Future<View> in
//        return try req.view().render("hello", ["name": "Leaf Ninja"])
//    }

//    // Example of configuring a controller
//    let todoController = TodoController()
//    router.get("todos", use: todoController.index)
//    router.post("todos", use: todoController.create)
//    router.delete("todos", Todo.parameter, use: todoController.delete)
//
    
    //
    let reportController = ReportController()
    
    router.post("reports", use: reportController.create)
    
    router.get("reports", use: reportController.index)
    
    router.get("list") { req -> Future<View> in
        
        let reports = Report.query(on: req).all()
        return try req.view().render("ReportList", ["data":reports])
    }
    
    
    // MARK: Actually used
    
    router.get { req -> Future<View> in
        
        let reports = LightReport.query(on: req).all()
        return try req.view().render("ReportList", ["data":reports])
    }
    
    router.post("uploads", use: reportController.upload)
}
