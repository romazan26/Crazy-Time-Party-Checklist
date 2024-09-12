//
//  Enums.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 12.09.2024.
//

import Foundation

enum SpinBack: CaseIterable, Identifiable{
    case back1
    case back2
    case back3
    case back4
    case back5
    
    var image: ImageResource {
        switch self{
            
        case .back1: .spinBack1
        case .back2: .spinBack2
        case .back3: .spinBack3
        case .back4: .spinBack4
        case .back5: .spinBack5
        }
    }
    var id: Self{
        self
    }
}

enum SpinColor: CaseIterable, Identifiable{
    case color1
    case color2
    case color3
    
    var spinColor: ImageResource {
        switch self{
 
        case .color1:
                .spinColor1
        case .color2:
                .spinColor2
        case .color3:
                .spinColor3
        }
    }
    
    var spin: ImageResource {
        switch self{
 
        case .color1:
                .spin1
        case .color2:
                .spin2
        case .color3:
                .spin3
        }
    }
    
    var Wheel: ImageResource {
        switch self{
 
        case .color1:
                .wheel1
        case .color2:
                .wheel2
        case .color3:
                .wheel3
        }
    }
    var id: Self{
        self
    }
}
