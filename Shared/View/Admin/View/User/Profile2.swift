//
//  Profile.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import SwiftUI
import PKHUD

struct OtherUser2: View {
    let user: UserModel
    @State var isUserBanned: Bool = false
    var body: some View {
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
                    
                    Section(header: Text("Info")) {
                        NavigationLink(destination: JoinedSocieties(user: user)){
                            Text("Societies")
                        }
                        NavigationLink(destination: JoinedActivities(user: user)){
                            Text("Activities")
                        }
                        
                    }
                    
                    Section(header: Text("Actions")) {
                        Button {
                            UserDB().update(item: UserModel(id: user.id, role: user.role, name: user.name, password: "123456", status: user.status))
                        } label: {
                            Text("Reset Password")
                        }
                        if(isUserBanned){
                            Button {
                                UserDB().update(item: UserModel(id: user.id, role: user.role, name: user.name, password: "123456", status: "normal"))
                                isUserBanned.toggle()
                                HUD.flash(.label("User Un-blocked"), delay: 1)
                            } label: {
                                Text("Un-block User")
                                    .foregroundColor(.green)
                            }
                        }else {
                            Button {
                                UserDB().update(item: UserModel(id: user.id, role: user.role, name: user.name, password: "123456", status: "blocked"))
                                HUD.flash(.label("User blocked"), delay: 1)
                                isUserBanned.toggle()
                            } label: {
                                Text("Block User")
                                    .foregroundColor(.red)
                            }
                        }

                    }
                    

                    
                }
                
                Spacer()
                
            }
            
            .navigationTitle("Profile")

        
        .navigationViewStyle(.stack)
        .onAppear{
            isUserBanned = user.status == "blocked"
        }
        
    }
    
    
    @ViewBuilder
    func profileView() -> some View{
        VStack(spacing: 7){
            Text("name: " + user.name)
            Text("username: " + user.id)
            Text("status: " + user.status)
            
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
