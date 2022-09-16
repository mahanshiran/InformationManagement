//
//  NoFeeds.swift
//  InformationManagement (iOS)
//
//  Created by 𝔲𝔤𝔩𝔶 ♡ on 9/15/22.
//

import SwiftUI

struct NoFeeds: View {
    
    @Binding var tab: Tab
    
    var body: some View {
                
        VStack {
            
            Text("You don't belong to any society")
                .foregroundColor(.secondary)
                .font(.caption)
            
            Button {} label: {
                
                Button { self.tab = Tab.societies } label: {
                    
                    Text("Join a society")
                    
                }
                
            }
            .font(.caption)
            
        }
        
    }
    
}

struct NoFeeds_Previews: PreviewProvider {
    static var previews: some View {
        NoFeeds( tab: .constant(Tab.home) )
    }
}
