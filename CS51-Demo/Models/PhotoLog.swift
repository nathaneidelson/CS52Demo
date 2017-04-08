//
//  Photo.swift
//  CS51-Demo
//
//  Created by Nathan Eidelson on 3/26/17.
//  Copyright © 2017 Nathan Eidelson. All rights reserved.
//

import UIKit
import Alamofire

// While we implement PhotoLogs here, this is fairly basic as a model. Let's consider a User model, which may have the following methods...

// "User" class methods:
//  get(id: string)
//  login(email: string, password: string, ...)
//  register(email: string, password: string, ...)
//  etc...

// "User" instance methods:
//  logout()
//  delete()
//  updateEmail()
//  updateProfilePicture()
//  etc...

class PhotoLog: NSObject {
    
    // REPLACE THIS with your Airtable base + table url
    static let airtableAPIUrl = "https://api.airtable.com/v0/appS4dWugwqgIushs/Photos"
    
    // What are the advantages of keeping this as class variable?
    // You can copy the array in other view controllers, and this will always remain an accurate
    // source of truth.
    static var photoLogs: [PhotoLog] = []
    
    // Required variables
    var id: String;
    var name: String;
    var url: String;
    var image: UIImage;
    // Optional variables
    var notes: String?;     
    
    init?(recordJSON: [String: Any]) {
        // You should NEVER assume anything about the server response.
        // All response handling code on the client should not crash due to missing/extra data.
        
        // 1. Avoid using the <Type>! (e.g. String!) variable type declaration... this allows nil upon
        //    initialization, but will crash upon access if it is still nil. It's confusing and often avoidable.
        // 2. Avoid using as!... this will crash the client if the server response is malformed. as? allows 
        //    the cast to fail, and causes the gaurded control flow to execute the else statement.
        
        guard
            let id = recordJSON["id"] as? String,
            let fields = recordJSON["fields"] as? [String: Any],
            let name = fields["name"] as? String,
            let notes = fields["notes"] as? String?,
            let file = fields["file"] as? [[String: Any]],
            let url = file[0]["url"] as? String
        else {
            // If ANY of the above fail, we fail to construct the photoLog and return nil.
            return nil
        }
        
        self.id = id
        self.name = name
        self.url = url
        self.notes = notes

        guard
            // After setting the url of the file, we actually fetch the data
            let nsurl = NSURL(string: self.url) as URL?,
            let data = NSData(contentsOf: nsurl) as Data?,
            let image = UIImage(data: data)
        else {
            return nil
        }
        
        self.image = image
    }
    
    class func fetchAll(callback: @escaping (Bool) -> Void) {
        // Much of this code is stolen from the Alamofire docs... check them out if you're interested.

        Alamofire.request(
            airtableAPIUrl,
            // The default http method is GET, but it's always good to be explicit
            method: .get,
            parameters: ["view": "Grid"], // REPLACE THIS with your Airtable view name
            encoding: URLEncoding.default,
            headers: ["Authorization": "Bearer keyRnHAoFhP36pWoC"] // REPLACE THIS with your Airtable API key
        ).responseJSON { response in
            
            guard response.result.isSuccess else {
                print("Error while fetching photo logs: \(String(describing: response.result.error))")
                callback(false)
                return
            }

            guard let value = response.result.value as? [String: Any],
                let records = value["records"] as? [[String: Any]] else {
                    print("Malformed data received from fetchAllRooms service")
                    callback(false)
                    return
            }
            
            PhotoLog.photoLogs = []
            for record in records {
                if let photoLog = PhotoLog(recordJSON: record) {
                    PhotoLog.photoLogs.append(photoLog)
                }
            }
            
            callback(true)
        }
    }

    class func create(image: UIImage, name: String, notes: String) {
        // I left this for you to  on your own time, if interested.
        // Note that the Airtable API allows you to create new records, but the attachment field
        // only takes urls so you'll need to find a Cocoapod (or use alamofire + another API) that 
        // will upload this UIImage and return a url, which you can then POST to Airtable.
    }
}
