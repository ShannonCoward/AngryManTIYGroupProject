//
//  RailsRequest.swift
//  AngryManTIYGroupProject
//
//  Created by Shannon Armon on 6/28/15.
//  Copyright (c) 2015 Shannon Armon. All rights reserved.
//

import UIKit

private let defaults = NSUserDefaults.standardUserDefaults()
private let _singleton = RailsRequest()

let API_URL = "angry-cons.herokuapp.com"


class RailsRequest: NSObject {
    
    //Singleton Class
    class func session() -> RailsRequest { return _singleton }
    
    var token: String? {
        
        get {
            
            return defaults.objectForKey("TOKEN") as? String
        }
        
        set {
            
            defaults.setValue(newValue, forKey: "TOKEN")
            defaults.synchronize()
            
        }
        
    }
    
    var username: String?
    var email: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    
    var guesses: String?
    
    var image: String?
    var answer: String?
    var answer_1: String?
    var answer_2: String?
    var answer_3: String?
    
    // If successful login or registration, this is filled
    var userInfo: [String:AnyObject]?
    
    func registerCompletion(completion: () -> Void) {
        
        var info =  [
            
            "method" : "Get",
            "endpoint" : "/levels:id"
        ]
    }
    

    
    func requestWithInfo(info: [String:AnyObject], andCompletion completion: ((responseInfo: [String:AnyObject]?) ->Void)?) {
        
        print("Inside RailsRequest 1")
        
        print(info)
        
        let endpoint = info["endpoint"] as! String
        if let url = NSURL(string: API_URL + endpoint) {
            
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = info["method"] as! String
            
            if RailsRequest.session().token != nil {
                
                print("Inside RailsRequest 2")
                
                request.setValue(RailsRequest.session().token!, forHTTPHeaderField: "Access-Token")
                
            }
            
            ////BODY
            
            if let bodyInfo = info["parameters"] as? [String:AnyObject] {
                
                let requestData = try? NSJSONSerialization.dataWithJSONObject(bodyInfo, options: NSJSONWritingOptions())
                
                let jsonString = NSString(data: requestData!, encoding: NSUTF8StringEncoding)
                
                let postLength = "\(jsonString!.length)"
                
                request.setValue(postLength, forHTTPHeaderField: "Content-Length")
                
                let postData = jsonString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                request.HTTPBody = postData
                
            }
            
            /////Body
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                
                if let json = (try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)) as? [String:AnyObject] {
                    
                    completion?(responseInfo: json)
                    
                }
                
            })
            
            
        }
        
    }
    
}

