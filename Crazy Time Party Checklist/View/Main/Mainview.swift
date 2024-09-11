//
//  Mainview.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 10.09.2024.
//

import SwiftUI

struct Mainview: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image(.onboardingBackGroud)
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    //MARK: - Logo
                    Image(.logo)
                        .resizable()
                        .frame(width: 206, height: 145)
                        .padding(.top, 62)
                    
                    //MARK: - Groupe of butons
                    ZStack{
                        //Button background
                        Image(.backGroundForButton)
                            .resizable()
                            .frame(width: scaleScreen_x(324), height: scaleScreen_y(362))
                        
                        //Buttons
                        VStack {
                            
                            //MARK: Spin button
                            NavigationLink {
                                Text("spin")
                            } label: {
                                ButtonMenuView(image: .button1,
                                               firstImage: .button1,
                                               secondImage: .button12,
                                               text: "SPIN THE WHEEL")
                            }

                            //MARK: Checklist button
                            NavigationLink {
                                CheckListsView()
                            } label: {
                                ButtonMenuView(image: .button2,
                                               firstImage: .button2,
                                               secondImage: .button22,
                                               text: "CHECKLIST")
                            }
                            
                            //MARK: Training button
                            NavigationLink {
                                Text("Trai")
                            } label: {
                                ButtonMenuView(image: .button3,
                                               firstImage: .button3,
                                               secondImage: .button32,
                                               text: "TRAINING")
                            }

                            //MARK: Setting button
                            NavigationLink {
                                Text("Set")
                            } label: {
                                Image(.setting)
                                    .resizable()
                                    .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                            }
                        }
                    }
                    
                    Spacer()
                }
                
            }
        }
    }
}

#Preview {
    NavigationView {
        Mainview()
    }
}
