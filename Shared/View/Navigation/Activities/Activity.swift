//
//  Activity.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/18.
//

import SwiftUI
import PKHUD

struct Activity: View {
    let user: UserModel
    let activity: ActivityModel
    let activityMemberDB = ActivityMemberDB()
    let publicationDB = PublicationDB()
    @State var showsSheet : Bool = false
    @State var isJoined : Bool = false
    @State var isFinished: Bool = false
    @State var activityMembers: [ActivityMember] = []
    @State var publications: [PublicationModel] = []
    @State var isAdmin: Bool = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            
            Divider()
            
            Form{
                
                Section {
                    
                    Text(activity.description)
                        .font(.footnote)
                        .opacity(0.8)
                        .padding(.vertical, 5)
                    
                } header: {
                    Text("About Activity")
                } footer: {
                    if(isFinished){
                        HStack{
                            Text("Finished")
                                .foregroundColor(Color.orange)
                            Spacer()
                            NavigationLink {
                                AllComments(user: user, passedUser: nil, activity: activity)
                            } label: {
                                Text("\(publications.count) Reviews")
                            }

                        }

                    }else {
                        HStack{
                            Text(activity.date, style: .date)
                                .font(.footnote)
                                .opacity(0.8)
                            
                            Text(activity.date, style: .time)
                                .font(.footnote)
                                .opacity(0.8)
                        }
                    }
                }


                
                if(activityMembers.count > 0){
                    
             
                        Section(header: Text("Members (\(activityMembers.count))")) {
                            ZStack{
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 0), count: 5), content: {
                                    ForEach(activityMembers,id:\.id){
                                    member in
                                        ZStack(alignment:.center){
                                            ActivityMemberGrid(item: member)
                                            if(member.uid == activity.creator){
                                                Image(systemName: "person.circle.fill")
                                                    .offset(y: -10)
                                                    .foregroundColor(.green)
                                                    
                                            }
                                        }
                                        .blur(radius: isJoined ? 0 : 3)
                                        
                                          
                                }

                                })
                                .padding(.top,15)
                                
                                if(!isJoined){
                                    Button {
                                        join()
                                    } label: {
                                        Text("Join to view")
                                            .fontWeight(.bold)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .foregroundColor(Color.black)
                                            .background(Color.orange)
                                            .cornerRadius(20)
                                    }
                                }
 
    
                            }
                        }

                }else {
                    //TODO: if no societies
                }
                
                
                Section(header: Text("Options")) {
                
                    
                    if(isFinished){
                        HStack{
                            Spacer()
                            Button {
                                showsSheet.toggle()
                            } label: {
                                Text("Write Summary")
                            }
                            Spacer()
                        }
                    }
                    
                    HStack{
                        Spacer()
                        if(isJoined){
                            Button {
                                if(isAdmin){
                                    HUD.flash(.label("Creator can't leave activity"), delay: 2)
                                }else {
                                    activityMemberDB.delete(userID: user.id, activity: activity.id)
                                    updateView()
                                }
                            } label: {
                                Text("Leave Activity")
                            }
                            .foregroundColor(Color.red)
                        }
                        else {
                            Button {
                                join()
                            } label: {
                                Text("Join Activity")
                            }
                            .foregroundColor(Color.green)
                        }

                        Spacer()
                    }
                    

                            
                        
                }
                
                if(activity.creator == user.id){
                    Section(header: Text("Admin Options"), content: {
                            
                            //MARK: The creator can add new members
                        HStack{
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("Invite Members")
                            }
                            Spacer()
                        }
                        
                        HStack{
                            Spacer()
                            Button {
                                ActivityDB().delete(idValue: activity.id)
                                activityMemberDB.delete(activity: activity.id)
                                //TODO: Maybe here need to delete all activities for activityUsers
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Delete Activity")
                                    .foregroundColor(Color.red)
                            }
                            Spacer()
                        }
                        })
                }
            }
            .navigationTitle(activity.name)
        }
        .onAppear{
            updateView()
            var seenActivities = UserDefaults.standard.stringArray(forKey: "seenActivities") ?? []
            
            if(!seenActivities.contains(activity.id)){
                seenActivities.append(activity.id)
                UserDefaults.standard.set(seenActivities, forKey: "seenActivities")
            }
        }
        .sheet(isPresented: $showsSheet) {
            updateView()
        } content: {
            ActivitySummary(user: user, activity: activity)
        }

        

      
    }
    func join(){
        ActivityMemberDB().add(item: ActivityMember(id: UUID().uuidString, uid: user.id, aid: activity.id, dateJoined: Date(), isApproved: false))
        updateView()
        
    }
    
    func updateView(){
        //MARK: Check if the user has joined the society
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation {
                isJoined = ActivityMemberDB().isAlreadyJoined(username: user.id, activityId: activity.id)
                if(isSupperAdmin(user: user)){
                    isJoined = true
                }
                isAdmin = activity.creator == user.id
                activityMembers = activityMemberDB.getAllForActivity(activityID: activity.id)
                isFinished = activity.date <= Date()
                publications = publicationDB.getAllForActivity(activity: activity.id)
            }
        }


    }
}

