//
//  SettingsView.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import SwiftUI
import StoreKit


struct SettingsView: View {
    
    @State private var soundLevel: Float = 0.5
    
    @Environment(\.dismiss) var dismiss
    @State private var isPresentShare = false
    @State private var isPresentPolicy = false
    @State var urlShare = "https://www.apple.com/app-store/"
    @StateObject var vm = SettingViewModel()
    
    var body: some View {
        ZStack {
            //MARK: - BackGround
            Image(.onboardingBackGroud)
                .resizable()
                .ignoresSafeArea()
            VStack {
                //MARK: - Title view
                ZStack {
                    backForText(width: 324, height: 48)
                    Text("SETTINGS")
                        .foregroundStyle(.white)
                        .font(.system(size: 24, weight: .heavy))
                }
                //MARK: - Groupe of butons
                ZStack{
                    //Button background
                    Image(.backGroundForButton)
                        .resizable()
                        .frame(width: scaleScreen_x(324), height: scaleScreen_y(469))
                        
                    
                    
                    VStack {
                        //Buttons standart
                        VStack{
                            //MARK: Policy button
                            
                            ButtonMenuView(image: .button1,
                                           firstImage: .button1,
                                           secondImage: .button12,
                                           text: "POLICY", action: {isPresentPolicy.toggle()})
                            
                            
                            
                            
                            //MARK: RATE button
                            ButtonMenuView(image: .button2,
                                           firstImage: .button2,
                                           secondImage: .button22,
                                           text: "RATE US", action: {SKStoreReviewController.requestReview()})
                            
                            
                            //MARK: Share button
                            ButtonMenuView(image: .button3,
                                           firstImage: .button3,
                                           secondImage: .button32,
                                           text: "SHARE", action: {isPresentShare.toggle()})
                        }
                        
                        //Slider buttons
                        VStack(spacing: 20){
                            SliderButtomSetting(text: "MUSIC", value: $vm.musicSlider)
                            SliderButtomSetting(text: "SOUNDS", value: $vm.soundsSlider)
                        }
                        
                    }
                    
                    
                }
                
                Button(action: {
                    vm.save()
                    dismiss()
                    SoundManager.instance.playSound(sound: .button)
                    
                }, label: {
                    BackForButton(text: "SAVE")
                })
                .padding(.top)
                Spacer()
                
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $isPresentShare, content: {
                ShareSheet(items: urlShare )
            })
            .sheet(isPresented: $isPresentPolicy, content: {
                WebViewPage(urlString: URL(string: "https://www.termsfeed.com/live/f7e5013a-ba3d-4e6c-abab-9b58d957f382")!)
            })
        }
    }
}

#Preview {
    SettingsView()
}
struct ShareSheet: UIViewControllerRepresentable{
    var items: String
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let av = UIActivityViewController(activityItems: [items], applicationActivities: nil)
        return av
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}


