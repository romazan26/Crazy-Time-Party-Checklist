//
//  PageIntroModel.swift
//  AircraftInspection
//
//  Created by Роман on 05.04.2024.
//

import Foundation

struct PageIntro: Identifiable,Equatable {
    let id = UUID()
    var imageUrl: String
    var tag: Int

    static var samplePage = PageIntro(imageUrl: "intro1", tag: 0)
    
    static var sampalePages: [PageIntro] = [
        PageIntro(imageUrl: "intro1", tag: 0),
        PageIntro(imageUrl: "intro2", tag: 1),
    ]
}
