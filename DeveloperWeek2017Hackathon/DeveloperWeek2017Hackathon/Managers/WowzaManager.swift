//
//  WowzaManager.swift
//  DeverloperWeekHackathon2017TestApp
//
//  Created by Ana Ma on 6/20/17.
//  Copyright © 2017 Ana Ma. All rights reserved.
//

import Foundation

class WowzaManager {
    
    static let shared = WowzaManager()
    private init () {}
    
    private let wscAPIKey = "eBXQ1hVAdr6t75XROdDVS3vgRo3fLtia6skoQ4zIazjaAMwwVCY09aXGvnor3503"
    private let wscAccesskey = "bAfc4CFI9UFNfILr4hadTPThQynm3GPIfq6K0VJ3aTehHAmtNQueDYpZFsnr334e"
    
    func getAllLiveStreams(callback: @escaping (([LiveStream]?) -> Void)) {
        let headers = [
            "wsc-api-key": wscAPIKey,
            "wsc-access-key": wscAccesskey,
            "cache-control": "no-cache",
            "postman-token": "ab3426ba-51b2-4829-1abb-08ced281aa3b"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.cloud.wowza.com/api/v1/live_streams/")! as URL,
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
                
                if let validLiveStreams = LiveStreamFactory.manager.getLiveStreamData(from: validData) {
                    callback(validLiveStreams)
                }
            }
        })
        
        dataTask.resume()
    }
}
