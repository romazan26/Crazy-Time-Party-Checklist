//
//  Mainview.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 10.09.2024.
//

import SwiftUI

struct Mainview: View {
    var body: some View {
        ZStack {
            Image(.onboardingBackGroud)
                .resizable()
                .ignoresSafeArea()
            VStack {
                Image(.logo)
                    .resizable()
                    .frame(width: 206, height: 145)
                    .padding(.top, 162)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            
        }
    }
}

#Preview {
    Mainview()
}
