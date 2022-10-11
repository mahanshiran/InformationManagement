//
//  NotificationCenter.swift
//  InformationManagement (iOS)
//
//  Created by 𝔲𝔤𝔩𝔶 ♡ on 9/15/22.
//

import SwiftUI

struct NotJoiendActivities: View {
    let user: UserModel
    @State var notJoiedActivities: [ActivityModel] = []
    var body: some View {
            
        VStack {
            
            if(notJoiedActivities.isEmpty){
                Text("No New Activities")
                    .opacity(0.7)
                
            }else {
                List(notJoiedActivities, id:\.id){
                    ac in
                    ActivityRow(user: user, activity: ac)
                }
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            notJoiedActivities = getNotJoinedActivities(user: user)
        }

    }
    
}

func getNotJoinedActivities(user: UserModel) -> [ActivityModel]{
    var allActivities : [ActivityModel] = []
    var notJoiedActivities : [ActivityModel] = []
    var societyMembers : [SocietyMember] = []
    var activityMembers : [ActivityMember] = []
    notJoiedActivities = []
    activityMembers = []
    allActivities = []
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// all activities
    societyMembers = SocietyMemberDB().getAllForUser(username: user.id)
    let societyMemberSIds = societyMembers.map{ $0.sid }
    for sid in societyMemberSIds{
        allActivities.append(contentsOf: ActivityDB().getForSociety(societyId: sid))//MARK: all activities
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// joined Activities
    activityMembers = ActivityMemberDB().getAllForUser(username: user.id)
    let activityMemberAIds = activityMembers.map{ $0.aid }
//            for aid in activityMemberAIds{
//                joinedActivities.append(contentsOf: ActivityDB().getById(aid: aid))//MARK:
//            }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// not joined Activities
    for activity in allActivities{
        if(!activityMemberAIds.contains(activity.id)){
            notJoiedActivities.append(activity)
        }
    }
    return notJoiedActivities
}
