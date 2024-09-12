//
//  pageSpinView.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 12.09.2024.
//

import SwiftUI

struct PageSpinView: View {
    var pageSpin: SpinFortune
    var body: some View {
        Image(uiImage: pageSpin.spin ?? UIImage(resource: .noSpinGame))
            .resizable()
        .scaledToFit()
    }
}

//#Preview {
//    PageSpinView()
//}
