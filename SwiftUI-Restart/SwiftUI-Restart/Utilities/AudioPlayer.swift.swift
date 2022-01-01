//
//  AudioPlayer.swift.swift
//  SwiftUI-Restart
//
//  Created by Ahmet on 1.01.2022.
//

import Foundation
import AVFoundation

enum SoundType: String {
    case m4a
    case mp3
}

enum SoundList: String {
    case chimeup
    case success
}

var audioPlayer: AVAudioPlayer?

func playSound(sound: SoundList, type: SoundType) {
    if let path = Bundle.main.path(forResource: sound.rawValue, ofType: type.rawValue) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: (URL(fileURLWithPath: path)))
            audioPlayer?.play()
        } catch {
            print("Could not play sound file.")
        }
    }
}
