//
//  ButtonPressAction.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 10.09.2024.
//

import Foundation
import SwiftUI

struct ButtonPress: ViewModifier{
    var onpress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onpress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}

extension View{
    func pressEvents(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(ButtonPress(onpress: {
            onPress()
        }, onRelease: {
            onRelease()
        }))
    }
}
