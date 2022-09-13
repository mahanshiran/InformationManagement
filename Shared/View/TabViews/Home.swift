//
//  Home.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import SwiftUI

struct Home: View {
    let userDB = UserDB()
    @State var users : [UserModel] = []
    var body: some View {
        
        VStack{
            
            Button {
                
                userDB.addCard(card: UserModel(id: UUID().uuidString,role: "role3"))
                
                users = userDB.getAll()
                
            } label: {
                Text("Add")
            }
            

            ForEach(users, id:\.id){
                user in
                Text(user.role)
            }
        }
        .onAppear{
            users = userDB.getAll()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
