//
//  SettingViewModel.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import Foundation
import SwiftUI
import MediaPlayer

final class SettingViewModel: ObservableObject{
    
    let sound = SoundManager.instance
    
    @Published var musicSlider: Double = 0
    @Published var wheelSlider: Double = 0
    @Published var soundsSlider: Double = 1 {
        didSet {
            sound.player?.volume = Float(soundsSlider)
        }
    }
}
extension MPVolumeView {
    static func setVolume(_ volume: Float) -> Void {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}
