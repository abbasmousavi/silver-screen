//
//  AVPlayerView.swift
//  Silver Screen
//
//  Created by Abbas Mousavi on 10/23/20.
//

import Foundation
import AVKit
import SwiftUI

struct AVPlayerView: UIViewControllerRepresentable {
    
   // typealias UIViewControllerType = <#type#>
    

    var videoURL: URL

    private var player: AVPlayer {
        
        return AVPlayer(url: URL(string: "https://stream1.eu.ir-cdn.xyz/movies/p/palm_springs_2020/720p/palm_springs_2020_1442_720p.m3u8")!)//videoURL)
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {
        if playerController.player == nil {
            playerController.player = player
            let subtitleFile = Bundle.main.path(forResource: "persian", ofType: "vtt")
            let subtitleURL = URL(fileURLWithPath: subtitleFile!)
            playerController.addSubtitles().open(fileFromLocal: subtitleURL)
        }
        
        playerController.player?.play()
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        var pit = AVPlayerViewController()
        pit.allowsPictureInPicturePlayback = true
        return pit
    }
}
