//
//  TabUIView.swift
//  InformationManagement
//
//  Created by 𝔲𝔤𝔩𝔶 ♡ on 9/1/22.
//

import SwiftUI

struct TabUIView: View {
    
    var body: some View {
        
        TabView {

            Home()
                .tabItem { Label("Home", systemImage: "house") }

            Societies()
                .tabItem { Label("Community", systemImage: "person.3") }

            Activities()
                .tabItem { Label("Profile", systemImage: "person") }
            
            Profile()
                .tabItem { Label("Profile", systemImage: "person") }
//
        }
            .accentColor(.black)
            
            
        
    }
    
    
}


struct TabUIView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        TabUIView()
        
    }
    
}
