//
//  SoundManager.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import Foundation
import AVKit

enum SoundOption: String{
    case backMenu
    case backSpin
    case button
    case spin
    case task
}

final class SoundManager {
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundOption){
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {return}
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }catch let error{
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}

final class MusicManager {
    static let instance = MusicManager()
    
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundOption){
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {return}
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }catch let error{
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
