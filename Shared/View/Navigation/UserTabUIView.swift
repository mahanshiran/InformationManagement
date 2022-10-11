//
//  TabUIView.swift
//  InformationManagement
//
//  Created by 𝔲𝔤𝔩𝔶 ♡ on 9/1/22.
//

import SwiftUI

struct UserTabUIView: View {
    
    let user: UserModel
    @Binding var isLoggedIn : Bool
    @State private var tab = Tab.home
    
    var body: some View {
        
        TabView (selection: $tab) {

            Home(tab: $tab,user: user)
                .tabItem { Label("Home", systemImage: "house") }
                .tag(Tab.home)

            Societies(user: user)
                .tabItem { Label("Societies", systemImage: "person.3") }
                .tag(Tab.societies)

            Activities(user: user)
                .tabItem { Label("Activities", systemImage: "square.stack.fill") }
                .tag(Tab.activities)
            
            Profile(user: user, isLoggedIn: $isLoggedIn)
                .tabItem { Label("Profile", systemImage: "person") }
                .tag(Tab.profile)
            
//            
//            //TODO:
//            Test()
//                .tabItem { Label("Test", systemImage: "highlighter") }
//                .tag(Tab.test)
            
        }
        
    }
    
}

//
//struct TabUIView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        
//        TabUIView()
//        
//    }
//    
//}
