//
//  StartSpinView.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 12.09.2024.
//

import SwiftUI

struct StartSpinView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: SpinViewModel
    let spin: SpinFortune
    
    var body: some View {
        ZStack {
            //MARK: - Background
            Image(uiImage: spin.backGround ?? UIImage(resource: .noSpinBack))
                .resizable()
                .ignoresSafeArea()
            VStack {
                //MARK: - Top tool bar
                HStack {
                    //MARK: Back button
                    Button {
                        dismiss()
                        SoundManager.instance.playSound(sound: .button)
                    } label: {
                        Image(.backButton)
                            .resizable()
                            .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    }
                    Spacer()
                    
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
                    //MARK: Menu button
                    Button {
                        dismiss()
                        SoundManager.instance.playSound(sound: .button)
                    } label: {
                        Image(.list)
                            .resizable()
                            .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    }
//                    NavigationLink {
//                        Mainview()
//                    } label: {
//                        Image(.list)
//                            .resizable()
//                            .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
//                    }
                }
                
                //MARK: - Name game and Task
                VStack{
                    Text(spin.nameGame ?? "Name game")
                        .foregroundStyle(.white)
                        .font(.system(size: 24, weight: .heavy))
                    Text("\(vm.wheelWinNumber). \(vm.simpleTaskText)")
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .heavy))
                        .multilineTextAlignment(.center)
                        .padding(8)
                        .background {
                            Color.backFortaask.cornerRadius(8)
                        }
                        .padding(8)
                }
                .padding(8)
                .background {
                    backForText(width: 324, height: .infinity)
                }
                
                Spacer()
                
                //MARK: - Spin of Fartune
                SpinRotationView(degrees: vm.simpleDegrees,
                                 wheel: spin.wheelColor ?? UIImage(resource: .wheel1),
                                 spin: spin.spin ?? UIImage(resource: .spin1))
                
                //MARK: - Start spin button
                Button {
                    vm.spining() 
                    vm.getTaskAfterSpin(spin: spin)
                    SoundManager.instance.playSound(sound: .spin)
                } label: {
                    BackForButton(text: "SPIN THE WHEEL")
                }
            }
            .padding()
            .navigationBarBackButtonHidden()
        }
        .onAppear(perform: {
            MusicManager.instance.playSound(sound: .backSpin)
        })
        .onDisappear(perform: {
            MusicManager.instance.playSound(sound: .backMenu)
        })
    }
}

//#Preview {
//    StartSpinView( vm: SpinViewModel(), spin: SpinFortune())
//}
