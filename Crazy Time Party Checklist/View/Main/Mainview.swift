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
                                SpinView()
                            } label: {
                                CustomButtonView(image: .button1, text: "SPIN THE WHEEL")
                            }

                            //MARK: Checklist button
                            NavigationLink {
                                CheckListsView().onAppear(perform: {
                                    SoundManager.instance.playSound(sound: .button)
                                })
                            } label: {
                                CustomButtonView(image: .button2, text: "CHECKLISTS")
                            }
                            
                            //MARK: Training button
                            NavigationLink {
                                IntroView()
                            } label: {
                                CustomButtonView(image: .button3, text: "TRAINING")
                            }

                            //MARK: Setting button
                            NavigationLink {
                                SettingsView().onAppear(perform: {
                                    SoundManager.instance.playSound(sound: .button)
                                })
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

struct CustomButtonView: View {
    var image: ImageResource
    var text: String
    var body: some View {
        ZStack{
            Image(image)
                .resizable()
                .frame(width: scaleScreen_x(264), height: scaleScreen_y(72))
            Text(text)
                .foregroundStyle(.white)
                .font(.system(size: 24, weight: .heavy, design: .monospaced))
        }
    }
}
