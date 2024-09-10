//
//  IntroView.swift
//  FastTrack
//
//  Created by Роман on 12.08.2024.
//

import SwiftUI

struct IntroView: View {
    @AppStorage("isFirstStart") var isFirstStart: Bool?
    
    @State private var isPresented = false
    @State private var pageIndex = 0
    @Environment(\.dismiss) var dismiss
    
    private let pages: [PageIntro] = PageIntro.sampalePages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {

            VStack {
              
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                    
                    TabView(selection: $pageIndex,
                            content:  {
                        ForEach(pages) { page in
                            PageIntroView(page: page)
                                .tag(page.tag)
                        }
                    })
                    .fullScreenCover(isPresented: $isPresented, content: {
                       // MainView()
                    })
                    .ignoresSafeArea()
                    .animation(.easeInOut, value: pageIndex)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                    
                }
                Spacer()
                //MARK: - Navigation Button
        
                    Button(action: {
                        pageIndex += 1
                        if pageIndex > pages.count - 1 {
                            isPresented = true
                            isFirstStart = false
                        }
                        
                    }, label: {
                        Image(.nextButton)
                            .resizable()
                            .frame(height: scaleScreen_y(134))
                    })
                    .offset(y: scaleScreen_y(35))
                    
                }
            
        
            .background {
                Image(.onboardingBackGroud)
                    .resizable()
                    .ignoresSafeArea()
            }
    }
    func incrementPage() {
        pageIndex += 1
    }
    func countUniqueElements(_ array: [Int]) -> Int {
        var uniqueElements = Set<Int>()
        
        for element in array {
            uniqueElements.insert(element)
        }
        
        return uniqueElements.count
    }
    
}

#Preview {
    IntroView()
}
extension View{
    func scaleScreen_y(_ value : CGFloat) -> CGFloat{
        let y = UIScreen.main.bounds.height/812
        return value * y
    }
    
    func scaleScreen_x(_ value : CGFloat) -> CGFloat{
        let x = UIScreen.main.bounds.width/375
        return value * x
    }
}
