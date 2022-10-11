import SwiftUI

struct AdminTabUIView: View {
    
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
            
            Profile(user: user, isLoggedIn: $isLoggedIn)
                .tabItem { Label("Profile", systemImage: "person") }
                .tag(Tab.profile)
            
        }
        
        
    }
    
}
