//
//  JoinedSocieties.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/17.
//

import SwiftUI

struct JoinedActivities: View {
    let user: UserModel
    let activityyMemberDB = ActivityMemberDB()
    @State var activityMembers : [ActivityMember] = []
    var body: some View {
        VStack{
            ScrollView
            {
                ForEach(activityMembers, id:\.id){
                    member in
                    JoinedActivityRow(item: member, user: user)
                }
            }

        }
        .onAppear{
            activityMembers = activityyMemberDB.getAllForUser(username: user.id)
        }
        .navigationTitle("Joined Activities")
    }
}
