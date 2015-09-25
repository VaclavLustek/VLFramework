//
//  VLNetwork.swift
//  Pods
//
//  Created by Václav Luštěk.
//
//

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Import

import AFNetworking
import Bolts
import AFNetworkActivityLogger


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Settings


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Constants


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Enums

public enum RequestType {
    case GET
    case POST
    case PUT
    case DELETE
}


// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Class

public class VLNetwork {
 
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    
    public static var baseURLString: String = ""
    public static var globalRequestHeaders: Dictionary<String, String>? = nil
    public static var globalManagerConfiguration: ((manager: AFHTTPRequestOperationManager) -> Void)? = nil
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Init
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Logging
    
    public class func enableLogging() {
        
        let logger: AFNetworkActivityLogger = AFNetworkActivityLogger.sharedLogger()
        logger.level = .AFLoggerLevelDebug
        logger.startLogging()
    }
    
    public class func disableLogging() {
        
        let logger: AFNetworkActivityLogger = AFNetworkActivityLogger.sharedLogger()
        logger.level = .AFLoggerLevelDebug
        logger.stopLogging()
    }
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - URL
    
    public class func urlStringFromEndPoint(endPoint: String) -> String {
        
        return String("\(self.baseURLString)/\(endPoint)")
    }
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Requests
    
    public class func asyncRequest(method method: RequestType, url: String) -> BFTask {
        
        return self.asyncRequest(method: method, url: url, parameters: nil)
    }
    
    public class func asyncRequest(method method: RequestType, url: String, parameters: AnyObject?) -> BFTask {
        
        return self.asyncRequest(method: method, url: url, parameters: parameters, configureManager: nil)
    }
    
    public class func asyncRequest(method method: RequestType, url: String, parameters: AnyObject?, configureManager: ((manager: AFHTTPRequestOperationManager) -> Void)?) -> BFTask {
        
        let source: BFTaskCompletionSource = BFTaskCompletionSource()
        
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        
        if let globalRequestHeaders: Dictionary<String, String> = self.globalRequestHeaders {
            for (key, value) in globalRequestHeaders {
                manager.requestSerializer.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let globalManagerConfiguration = self.globalManagerConfiguration {
            globalManagerConfiguration(manager: manager)
        }
        
        if (configureManager != nil) {
            configureManager!(manager: manager)
        }
        
        switch (method) {
            
        case .GET:
            manager.GET(url, parameters: parameters,
                success: { (operation: AFHTTPRequestOperation, responseObject: AnyObject) -> Void in
                    source.setResult(responseObject)
                    
                }, failure: { (operation: AFHTTPRequestOperation, error: NSError) -> Void in
                    source.setError(error)
            })
            
        case .POST:
            manager.POST(url, parameters: parameters,
                success: { (operation: AFHTTPRequestOperation, responseObject: AnyObject) -> Void in
                    source.setResult(responseObject)
                    
                }, failure: { (operation: AFHTTPRequestOperation, error: NSError) -> Void in
                    source.setError(error)
            })
            
        case .PUT:
            manager.PUT(url, parameters: parameters,
                success: { (operation: AFHTTPRequestOperation, responseObject: AnyObject) -> Void in
                    source.setResult(responseObject)
                    
                }, failure: { (operation: AFHTTPRequestOperation, error: NSError) -> Void in
                    source.setError(error)
            })
            
        case .DELETE:
            manager.DELETE(url, parameters: parameters, success: { (operation: AFHTTPRequestOperation, responseObject: AnyObject) -> Void in
                source.setResult(responseObject)
                
                }, failure: { (operation: AFHTTPRequestOperation, error: NSError) -> Void in
                    source.setError(error)
            })
        }
        
        return source.task;
    }
    
}
