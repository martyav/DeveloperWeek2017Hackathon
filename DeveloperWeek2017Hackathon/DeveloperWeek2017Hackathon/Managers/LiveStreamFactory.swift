//
//  LiveStreamFactory.swift
//  DeverloperWeekHackathon2017TestApp
//
//  Created by Ana Ma on 6/20/17.
//  Copyright © 2017 Ana Ma. All rights reserved.
//

import Foundation

class LiveStream {
    var id: String
    var name: String
    var transcoderType: String
    var broadcastLocation: String
    var billingMode: String
    var recording: Bool
    var playerId: String
    var playerEmbedCode: String
    var playerHlsPlaybackUrl: String
    var hostedPageTitle: String
    
    init (id: String,
          name: String,
          transcoderType: String,
          broadcastLocation: String,
          billingMode: String,
          recording: Bool,
          playerId: String,
          playerEmbedCode: String,
          playerHlsPlaybackUrl: String,
          hostedPageTitle: String){
        self.id = id
        self.name = name
        self.transcoderType = transcoderType
        self.broadcastLocation = broadcastLocation
        self.billingMode = billingMode
        self.recording = recording
        self.playerId = playerId
        self.playerEmbedCode = playerEmbedCode
        self.playerHlsPlaybackUrl = playerHlsPlaybackUrl
        self.hostedPageTitle = hostedPageTitle
    }
}

class LiveStreamFactory {
    
    // MARK: - Singleton
    static let manager: LiveStreamFactory = LiveStreamFactory()
    private init() {}
    
    // MARK: - Data parsing
    func getLiveStreamData(from data: Data) -> [LiveStream]? {
        
        var liveStreamsArray = [LiveStream]()
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let liveStreamData = jsonData as? [String:AnyObject],
            let liveStreams = liveStreamData["live_streams"] as? [[String:AnyObject]] else { return nil }
            
            for liveStream in liveStreams {
                guard let id = liveStream["id"] as? String,
                    let name = liveStream["name"] as? String,
                    let transcoderType = liveStream["transcoder_type"] as? String,
                    let broadcastLocation = liveStream["broadcast_location"] as? String,
                
                    let billingMode = liveStream["billing_mode"] as? String,
                    let recording = liveStream["recording"] as? Bool,
                    
                    let playerId = liveStream["player_id"] as? String,
                    let playerEmbedCode = liveStream["player_embed_code"] as? String,
                    let playerHlsPlaybackUrl = liveStream["player_hls_playback_url"] as? String,
                    let hostedPageTitle = liveStream["hosted_page_title"] as? String else { return  nil }
                
                liveStreamsArray.append(LiveStream(id: id, name: name, transcoderType: transcoderType, broadcastLocation: broadcastLocation, billingMode: billingMode, recording: recording, playerId: playerId, playerEmbedCode: playerEmbedCode, playerHlsPlaybackUrl: playerHlsPlaybackUrl, hostedPageTitle: hostedPageTitle))
                
            }
            //dump(liveStreams) //something
        } catch {
            print("Unknown parsing error encountered: \(error)")
        }
        return liveStreamsArray
    }
    
    
}
