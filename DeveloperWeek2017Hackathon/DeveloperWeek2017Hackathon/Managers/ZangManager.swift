//
//  ZangManager.swift
//  DeveloperWeek2017Hackathon
//
//  Created by Ana Ma on 6/19/17.
//  Copyright © 2017 Ana Ma. All rights reserved.
//

import Foundation

class ZangManager {
    
    private let accountSid = "AC65889084794080b448164c34ac90b341"
    private let authToken = "975d3bd90b834f9aaa48d45ad4804c78"
    
    func getNotification(with notificationSid: String) {
        let headers = [
            "authorization": "Basic QUM2NTg4OTA4NDc5NDA4MGI0NDgxNjRjMzRhYzkwYjM0MTo5NzVkM2JkOTBiODM0ZjlhYWE0OGQ0NWFkNDgwNGM3OA==",
            "cache-control": "no-cache",
            "postman-token": "385aaea1-c0e4-e7d9-0501-556512f00b33"
        ]
        
//        let request = NSMutableURLRequest(url: NSURL(string: "https://api.zang.io/v2/Accounts/AC65889084794080b448164c34ac90b341/Notifications/NO078890845a1fb731856b496cbae9a366.json")! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: 10.0)
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.zang.io/v2/Accounts/\(accountSid)/Notifications/\(notificationSid).json")! as URL,
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
    
    func makeACall(fromNumber: String = "9179001789", toNumber: String = "9173629459", urlString: String ) {
        let headers = [
            "authorization": "Basic QUM2NTg4OTA4NDc5NDA4MGI0NDgxNjRjMzRhYzkwYjM0MTo5NzVkM2JkOTBiODM0ZjlhYWE0OGQ0NWFkNDgwNGM3OA==",
            "cache-control": "no-cache",
            "postman-token": "7b7a6abc-bc06-8089-270e-24cd17979c19"
        ]
        
        guard let validURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
//        let request = NSMutableURLRequest(url: NSURL(string: "https://api.zang.io/v2/Accounts/AC65889084794080b448164c34ac90b341/Calls.json?To=%2019174760615&From=%2019173795525&Url=http%3A%2F%2Fzang.io%2Fivr%2Fwelcome%2Fcall")! as URL,
//                                        cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: 10.0)
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.zang.io/v2/Accounts/\(accountSid)/Calls.json?To=%201\(toNumber)&From=%201\(fromNumber)&Url=\(validURLString)")! as URL,
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
        dataTask.resume()
    }
    
    func getAllAvailableNumbers(country: String = "US", type: String = "Local") -> [Phone]? {
        var arrayPhones = [Phone]()
        
        let headers = [
            "authorization": "Basic QUM2NTg4OTA4NDc5NDA4MGI0NDgxNjRjMzRhYzkwYjM0MTo5NzVkM2JkOTBiODM0ZjlhYWE0OGQ0NWFkNDgwNGM3OA==",
            "cache-control": "no-cache",
            "postman-token": "89256fd5-213f-2fc9-a3f2-4b889de85755"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.zang.io/v2/Accounts/\(accountSid)/AvailablePhoneNumbers/\(country)/\(type).json")! as URL,
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
                guard let validData = data else { return }
                
                if let validPhones = PhoneFactory.manager.getAvailablePhoneNumberData(from: validData) {
                    arrayPhones = validPhones
                }
            }
        })
        
        dataTask.resume()
        //dump(arrayPhones) //nothing
        return arrayPhones
    }

    
    func addNumber(number: String = "9892560912", areaCode: String = "1") {
        let headers = [
            "authorization": "Basic QUM2NTg4OTA4NDc5NDA4MGI0NDgxNjRjMzRhYzkwYjM0MTo5NzVkM2JkOTBiODM0ZjlhYWE0OGQ0NWFkNDgwNGM3OA==",
            "cache-control": "no-cache",
            "postman-token": "f368722a-69f6-38f6-d948-12587aca1341"
        ]
        
        //let request = NSMutableURLRequest(url: NSURL(string: "https://api.zang.io/v2/Accounts/AC65889084794080b448164c34ac90b341/IncomingPhoneNumbers.json?AreaCode=1&PhoneNumber=9892560912")! as URL,
        //cachePolicy: .useProtocolCachePolicy,
        //timeoutInterval: 10.0)
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.zang.io/v2/Accounts/AC65889084794080b448164c34ac90b341/IncomingPhoneNumbers.json?AreaCode=\(areaCode)&PhoneNumber=\(number)")! as URL,
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
        dataTask.resume()
    }
    
    func sendSMS(fromNumber: String = "9179001789", toNumber:String = "9173629459", bodyMessage: String) {
        let headers = [
            "authorization": "Basic QUM2NTg4OTA4NDc5NDA4MGI0NDgxNjRjMzRhYzkwYjM0MTo5NzVkM2JkOTBiODM0ZjlhYWE0OGQ0NWFkNDgwNGM3OA==",
            "cache-control": "no-cache",
            "postman-token": "27108618-40d3-534f-cff9-73b6f7b0c60b"
        ]
        
        guard let validBodyString = bodyMessage.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.zang.io/v2/Accounts/AC65889084794080b448164c34ac90b341/SMS/Messages?To=%201\(toNumber)&From=%201\(fromNumber)&Body=\(validBodyString)")! as URL,
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
        dataTask.resume()
    }
}


