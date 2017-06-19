//
//  ZangManager.swift
//  DeveloperWeek2017Hackathon
//
//  Created by Ana Ma on 6/19/17.
//  Copyright © 2017 Ana Ma. All rights reserved.
//

import Foundation

class ZangManager {
    func getNotification(with notificationSid: String) {
        let headers = [
            "authorization": "Basic QUM2NTg4OTA4NDc5NDA4MGI0NDgxNjRjMzRhYzkwYjM0MTo5NzVkM2JkOTBiODM0ZjlhYWE0OGQ0NWFkNDgwNGM3OA==",
            "cache-control": "no-cache",
            "postman-token": "385aaea1-c0e4-e7d9-0501-556512f00b33"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.zang.io/v2/Accounts/AC65889084794080b448164c34ac90b341/Notifications/NO078890845a1fb731856b496cbae9a366.json")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })
        
        dataTask.resume()
    }
    
    func makeACall(fromNumber: String, toNumber: String, UrlString: String ) {
        let headers = [
            "authorization": "Basic QUM2NTg4OTA4NDc5NDA4MGI0NDgxNjRjMzRhYzkwYjM0MTo5NzVkM2JkOTBiODM0ZjlhYWE0OGQ0NWFkNDgwNGM3OA==",
            "cache-control": "no-cache",
            "postman-token": "7b7a6abc-bc06-8089-270e-24cd17979c19"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.zang.io/v2/Accounts/AC65889084794080b448164c34ac90b341/Calls.json?To=%2019174760615&From=%2019173795525&Url=http%3A%2F%2Fzang.io%2Fivr%2Fwelcome%2Fcall")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })
    }
}


