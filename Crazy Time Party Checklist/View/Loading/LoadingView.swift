//
//  ContentView.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 10.09.2024.
//

import SwiftUI

struct LoadingView: View {
    
    @AppStorage("isFirstStart") var isFirstStart: Bool?
    
    @State private var isPresent = false
    @State private var dotIndex = 0
      private let loadingText = "Loading"
      private let maxDots = 3
    
    var body: some View {
        VStack {
            //MARK: - Logo
            ZStack {
                Circle()
                    .foregroundColor(.pinkApp)
                    .frame(width: 287)
                    .blur(radius: 40)
                Image(.logo)
                    .resizable()
                .frame(width: 370, height: 258)
            }
            //MARK: - Loading text
            Text("\(loadingText)\(String(repeating: ".", count: dotIndex))\(String(repeating: " ", count: maxDots - dotIndex))")
                .foregroundStyle(.white)
                .font(.system(size: 28, weight: .heavy, design: .monospaced))
                .padding()
                .frame(width: 250, alignment: .center)
                
                
        }
        .onAppear {startLoadingAnimation()}
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Image(.backGround)
                .resizable()
                .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $isPresent, content: {
            if isFirstStart ?? true {
                IntroView()
            }else {
                Mainview()
            }
        })
    }
    //MARK - Function timer loading
    private func startLoadingAnimation() {
        var percents = 0
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                dotIndex = (dotIndex + 1) % (maxDots + 1)
            
                if percents < 10{
                    percents += 1
                }else {
                    timer.invalidate()
                    isPresent.toggle()
                }
            }
        }
}

#Preview {
    LoadingView()
}
