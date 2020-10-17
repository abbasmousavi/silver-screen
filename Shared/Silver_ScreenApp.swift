//
//  Silver_ScreenApp.swift
//  Shared
//
//  Created by Abbas Mousavi on 7/25/20.
//

import SwiftUI
import AVFoundation

@main
struct Silver_ScreenApp: App {
    
    init() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback)
        } catch  {
            
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
