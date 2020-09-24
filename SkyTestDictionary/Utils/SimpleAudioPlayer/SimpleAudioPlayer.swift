//
//  SimpleAudioPlayer.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 24.09.2020.
//

import Foundation
import AVFoundation

class SimpleAudioPlayer {
    
    var audioPlayer: AVAudioPlayer?
    
    func play(url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            audioPlayer = nil
        }
    }
}
