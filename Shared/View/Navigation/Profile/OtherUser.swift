//
//  Profile.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import SwiftUI

struct OtherUser: View {
    let user: UserModel
    var body: some View {
        NavigationView{
            
            VStack{
                Divider()
                
                Image(user.id)
                    .resizable()
                    .background(Color.gray)
                    .scaledToFit()
                    .frame(width: 150, height: 150, alignment: .center)
                    .clipShape(Circle())
                    .padding()
                
                profileView()
                    .padding()
                
                Spacer()
                
                Form{
                    NavigationLink(destination: JoinedSocieties(user: user)){
                        Text("Joined Societies")
                    }
                    NavigationLink(destination: JoinedActivities(user: user)){
                        Text("Joined Activities")
                    }
                }
                
                Spacer()
                
            }
            
            .navigationTitle("Profile")

        }
        .navigationViewStyle(.stack)
        
    }
    
    
    @ViewBuilder
    func profileView() -> some View{
        VStack(spacing: 7){
            Text("name: " + user.name)
            Text("username: " + user.id)
            
            //Text(user.password)
        }
        .opacity(0.8)
    }
    
    
}

//struct Profile_Previews: PreviewProvider {
//    static var previews: some View {
//        Profile()
//    }
//}
