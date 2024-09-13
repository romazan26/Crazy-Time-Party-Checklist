//
//  SettingViewModel.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import Foundation
import SwiftUI


final class SettingViewModel: ObservableObject{
    
    @AppStorage("volumeMusic") var volumeMusic: String?
    @AppStorage("volumeSound") var volumeSound: String?
    
    let sound = SoundManager.instance
    let music = MusicManager.instance
    
    init() {
        soundsSlider = Double(volumeSound ?? "0") ?? 0
        musicSlider = Double(volumeMusic ?? "0") ?? 0
    }
    
    @Published var musicSlider: Double = 1 {
        didSet{
            music.player?.volume = Float(musicSlider)
        }
    }
    @Published var soundsSlider: Double = 1 {
        didSet {
            sound.player?.volume = Float(soundsSlider)
        }
    }
    
    //MARK: - Save settings
    func save(){
        volumeMusic = String(musicSlider)
        volumeSound = String(soundsSlider)
    }
}

