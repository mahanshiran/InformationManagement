//
//  Home.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import SwiftUI

enum Tab{
    case home, societies,activities, profile, test
}

struct Home: View {
    
    @State private var navigator = "Home"
    @Binding var tab: Tab
    let user: UserModel
    let socDB = SocietyDB()
    @State var societies : [SocietyModel] = []
    @State var showsSheet: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack (alignment: .center) {
                
                Divider()
              
                
                Spacer()
                
                if societies.isEmpty { NoFeeds(tab: $tab) } else {
                    
//                    List(societies, id:\.id){
//                        item in
//                        SocietyRow(item: item)
//                    }
                }
                Spacer()
                
                
                
            }
            .onAppear{
                //societies = socDB.getForUser(user: user.username).filter{ $0}
            }
            .navigationTitle(navigator)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink { NotificationCenter() } label: { Image(systemName: "bell.fill") }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { tab = Tab.activities } label: { Image(systemName: "person.crop.circle.fill") }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 4){
                        Image(systemName: "circle.fill")
                            .font(.system(size: 6))
                            .foregroundColor(Color.green)
                            .offset(y: 1)
                            
                        Text(user.username)
                            .fontWeight(.semibold)
                    }
                    
                }

            }
            
        }
        
    }
    
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home( tab: .constant(Tab.home) )
//    }
//}
