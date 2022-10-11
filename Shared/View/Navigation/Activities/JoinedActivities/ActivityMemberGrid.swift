//
//  JoinedSocietyRow.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/17.
//

import SwiftUI

struct ActivityMemberGrid: View {
    let item: ActivityMember
    @State var user: UserModel = UserModel()
    var body: some View {
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
        .onAppear{
            user = UserDB().getUserWithUsername(userName: item.uid) ?? UserModel()
        }
    }
}

