//
//  AudioPlayerService.swift
//  tip-calculator
//
//  Created by Никита Яровой on 06.03.2025.
//

import Foundation
import AVFoundation

protocol AudioPlayerService {
    func playSound()
}

final class DefaultAudioPlayerService: AudioPlayerService {
    private var player: AVAudioPlayer?
    
    func playSound() {
        let path = Bundle.main.path(forResource: "click", ofType: "m4a")!
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch(let error) {
            print("DEBUG: Error playing sound: \(error.localizedDescription)")
        }
    }
}
