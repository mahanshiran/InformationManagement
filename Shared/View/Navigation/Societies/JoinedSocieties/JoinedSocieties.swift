//
//  JoinedSocieties.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/17.
//

import SwiftUI

struct JoinedSocieties: View {
    let user: UserModel
    let societyMemberDB = SocietyMemberDB()
    @State var societyMembers : [SocietyMember] = []
    var body: some View {
        VStack{
            ScrollView{
                ForEach(societyMembers, id:\.id){
                    member in
                    JoinedSocietyRow(item: member, user: user)
                }
            }
        }
        .onAppear{
            societyMembers = societyMemberDB.getAllForUser(username: user.id)
        }
        .navigationTitle("Joined Socities")
    }
}
