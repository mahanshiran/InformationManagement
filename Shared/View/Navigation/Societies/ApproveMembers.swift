//
//  ApproveMembers.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/22.
//

import SwiftUI

struct ApproveMembers: View {
    let society: SocietyModel
    let user: UserModel
    @State var refresh: Bool = false
    @State var societyMembers: [SocietyMember] = []
    var body: some View {
        VStack{
            Text("New Members")
                .font(.title)
            Divider()
                .padding(.bottom)
            
            List(societyMembers, id:\.id){
                member in
                SocietyMemberRow(item: member,refresh: $refresh)
            }
            .onChange(of: refresh) { _ in
                withAnimation {
                    societyMembers = SocietyMemberDB().getAllForSociety(societyID: society.id, approved: false)
                }
            }
            
        }
        .onAppear{
            societyMembers = SocietyMemberDB().getAllForSociety(societyID: society.id, approved: false)
        }
    }
}




struct SocietyMemberRow: View {
    let item: SocietyMember
    @State var user: UserModel = UserModel()
    @Binding var refresh: Bool
    var body: some View {
        HStack{
            HStack(alignment:.top){
                
                Image(user.id)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/7, height: UIScreen.main.bounds.width/7, alignment: .center)
                    .foregroundColor(Color.white.opacity(0.5))
                    .cornerRadius(5)
                    
                VStack(alignment:.leading, spacing: 5){
                    Text(user.name)
                        .font(.system(size: 15).bold())
                        .lineLimit(1)
                    
                    Text(item.dateJoined, style: .date)
                        .font(.system(size: 11))
                        .lineLimit(1)
                        .opacity(0.5)
                    Spacer()
                }

                

            }
            
            Spacer()
            
            Button {
                SocietyMemberDB().update(item: SocietyMember(id: item.id, uid: item.uid, sid: item.sid, dateJoined: Date(), isApproved: true))
                refresh.toggle()
                
            } label: {
                Text("Approve")
            }

        }
        .padding(.vertical, 5)
        .onAppear{
            user = UserDB().getUserWithUsername(userName: item.uid) ?? UserModel()
        }
    }
}
