//
//  JoinedSocietyRow.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/17.
//

import SwiftUI

struct SocietyMemberGrid: View {
    let item: SocietyMember
    @State var user: UserModel = UserModel()
    var body: some View {
        //NavigationLink(destination: OtherUser(user: user)){
            VStack{
                Image(user.id)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/7, height: UIScreen.main.bounds.width/7, alignment: .center)
                    .foregroundColor(Color.white.opacity(0.5))
                    .cornerRadius(5)
                    
                Text(user.name)
                    .font(.system(size: 12))
                    .lineLimit(1)
                    .frame(width: UIScreen.main.bounds.width/10 - 5)
                    .opacity(0.8)

            }
            
       // }
        .buttonStyle(.plain)
        .onAppear{
            user = UserDB().getUserWithUsername(userName: item.uid) ?? UserModel()
        }
    }
}

