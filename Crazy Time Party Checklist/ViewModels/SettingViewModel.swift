//
//  SettingViewModel.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import Foundation
import SwiftUI


final class SettingViewModel: ObservableObject{
    
    let sound = SoundManager.instance
    let music = MusicManager.instance
    
    @Published var musicSlider: Double = 1 {
        didSet{
            music.player?.volume = Float(musicSlider)
        }
    }
    @Published var wheelSlider: Double = 0
    @Published var soundsSlider: Double = 1 {
        didSet {
            sound.player?.volume = Float(soundsSlider)
        }
    }
}

