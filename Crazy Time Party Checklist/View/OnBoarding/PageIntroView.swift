//
//  PageIntroView.swift
//  AircraftInspection
//
//  Created by Роман on 05.04.2024.
//

import SwiftUI

struct PageIntroView: View {
    var page: PageIntro
    
    var body: some View {

                    Image(page.imageUrl)
                        .resizable()
                    .scaledToFit()
                        
 
    }
}


#Preview {
    PageIntroView(page: PageIntro.samplePage)
}
