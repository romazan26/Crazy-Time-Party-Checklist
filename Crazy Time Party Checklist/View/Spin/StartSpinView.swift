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
            Image(uiImage: vm.simpleBackGround)
                .resizable()
                .ignoresSafeArea()
            VStack {
                //MARK: - Top tool bar
                HStack {
                    //MARK: Back button
                    Button {
                        dismiss()
                    } label: {
                        Image(.backButton)
                            .resizable()
                            .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    }
                    Spacer()
                    
                    //MARK: Setting button
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(.setting)
                            .resizable()
                            .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    }
                    //MARK: Menu button
                    NavigationLink {
                        Mainview()
                    } label: {
                        Image(.list)
                            .resizable()
                            .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    }
                }
                
                //MARK: - Name game and Task
                VStack{
                    Text("Name game")
                        .foregroundStyle(.white)
                        .font(.system(size: 24, weight: .heavy))
                    Text("2. Make a crooked face at the camera")
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .heavy))
                        .multilineTextAlignment(.center)
                        .padding()
                        .background {
                            Color.backFortaask.cornerRadius(8)
                        }
                        .padding(5)
                }
                .padding()
                .background {
                    backForText(width: 324, height: .infinity)
                }
                
                Spacer()
                
                //MARK: - Spin of Fartune
                SpinRotationView(degrees: vm.simpleDegrees,
                                 wheel: UIImage(resource: .wheel1),
                                 spin: .spin1)
                
                Button {
                    vm.spining()                    
                } label: {
                    BackForButton(text: "SPIN THE WHEEL")
                }
            }
            .padding()
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    StartSpinView( vm: SpinViewModel(), spin: SpinFortune())
}
