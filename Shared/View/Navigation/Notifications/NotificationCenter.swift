//
//  NotificationCenter.swift
//  InformationManagement (iOS)
//
//  Created by 𝔲𝔤𝔩𝔶 ♡ on 9/15/22.
//

import SwiftUI

struct NotificationCenter: View {
    @State private var navigator = "Notification Center"
    
    var body: some View {
            
            VStack {
                
                Text("Hello, World!")
                
            }
                .navigationTitle(navigator)
                .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

struct NotificationCenter_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCenter()
    }
}
