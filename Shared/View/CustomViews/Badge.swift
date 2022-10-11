//
//  Badge.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/22.
//

import SwiftUI

struct Badge: View {
    let count: Int

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.clear
            Text(String(count))
                .font(.system(size: 10).bold())
                .padding(3)
            
                .background(Color.red)
                .foregroundColor(Color.white)
                .clipShape(Circle())
                // custom positioning in the top-right corner
                .alignmentGuide(.top) { $0[.bottom] }
                .alignmentGuide(.trailing) { $0[.trailing] - $0.width * 0.25 }
        }
        .opacity(count <= 0 ? 0 : 1)
    }
}
