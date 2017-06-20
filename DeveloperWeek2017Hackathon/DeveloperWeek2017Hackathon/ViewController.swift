//
//  ViewController.swift
//  DeveloperWeek2017Hackathon
//
//  Created by Ana Ma on 6/19/17.
//  Copyright © 2017 Ana Ma. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var streamPlayerView: UIView!
    var moviePlayer:AVPlayerViewController!
    var streamingPlaybackURL: String!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var messageField: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://wowzaprod120-i.akamaihd.net/hls/live/266794/2966a2f1/playlist.m3u8")!
        
        let player = AVPlayer(url: url as URL)
        moviePlayer = AVPlayerViewController()
        moviePlayer.player = player
        moviePlayer.view.frame = self.streamPlayerView.frame
        self.streamPlayerView.addSubview(moviePlayer.view)
        self.moviePlayer.player!.play()
        
        //publish a stream
        //        self.publishStream(new: false)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getStreamsList()
    }
    
    @IBAction func sendSMSButtonPressed(_ sender: UIButton) {
        
        ZangManager.shared.sendSMS(toNumber: "9173795525", bodyMessage: "New live stream available on zamhack://zang")
    }
    
    
    
    func getStreamsList(){
        let headers = [
            "wsc-api-key": "eBXQ1hVAdr6t75XROdDVS3vgRo3fLtia6skoQ4zIazjaAMwwVCY09aXGvnor3503",
            "wsc-access-key": "bAfc4CFI9UFNfILr4hadTPThQynm3GPIfq6K0VJ3aTehHAmtNQueDYpZFsnr334e",
            "cache-control": "no-cache",
            "postman-token": "7d63c83a-7043-cd60-5fd9-1670ee2d5ffc"
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
                print(httpResponse )
                let dataJson = try? JSONSerialization.jsonObject(with: data!, options: [])
                if let dataDictionary = dataJson as? [String: Any] {
                    
                    if let liveStreamsArray = dataDictionary["live_streams"] as? [Any] {
                        for object in liveStreamsArray {
                            if let myStream = object as? [String: Any]{
                                if let myStreamName = myStream["name"] as? String{
                                    print("Stream: " + myStreamName)
                                    if myStreamName == "ZAMHack" {
                                        self.streamingPlaybackURL = myStream["player_hls_playback_url"] as? String
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        })
        
        dataTask.resume()
    }
    
    func publishStream(new:Bool){
        
        let headers = [
            "wsc-api-key": "eBXQ1hVAdr6t75XROdDVS3vgRo3fLtia6skoQ4zIazjaAMwwVCY09aXGvnor3503",
            "wsc-access-key": "bAfc4CFI9UFNfILr4hadTPThQynm3GPIfq6K0VJ3aTehHAmtNQueDYpZFsnr334e",
            "content-type": "application/json",
            "cache-control": "no-cache",
            "postman-token": "098ce81e-dbf6-ce86-6937-0e312f749d02"
        ]
        let parameters = ["live_stream": [
            "name": "ZAMHack",
            "transcoder_type": "transcoded",
            "billing_mode": "pay_as_you_go",
            "broadcast_location": "us_west_california",
            "encoder": "ipcamera",
            "source_url": "http://198.233.230.244/axis-media/media.amp",
            "aspect_ratio_width": 1920,
            "aspect_ratio_height": 1080
            ]] as [String : Any]
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.cloud.wowza.com/api/v1/live_streams/kzsjygfx")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        if new == true {
            request.httpMethod = "POST"
        } else{
            request.httpMethod = "PATCH"
        }
        
        
        request.allHTTPHeaderFields = headers
        request.httpBody = postData! as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                //start the stream
                self.startStreaming()
            }
        })
        
        dataTask.resume()
    }
    
    func startStreaming(){
        
        let headers = [
            "wsc-api-key": "eBXQ1hVAdr6t75XROdDVS3vgRo3fLtia6skoQ4zIazjaAMwwVCY09aXGvnor3503",
            "wsc-access-key": "bAfc4CFI9UFNfILr4hadTPThQynm3GPIfq6K0VJ3aTehHAmtNQueDYpZFsnr334e",
            "cache-control": "no-cache",
            "postman-token": "2b0920c9-498b-bf23-20f9-91d790a068e9"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.cloud.wowza.com/api/v1/players/1fjqp8jd/start/")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "PUT"
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

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
