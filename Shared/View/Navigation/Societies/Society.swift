//
//  Activity.swift
//  InformationManagement (iOS)
//
//  Created by 𝔲𝔤𝔩𝔶 ♡ on 9/14/22.
//

import SwiftUI
import PKHUD

struct Society: View {
    let user: UserModel
    let society: SocietyModel
    let societyDB = SocietyDB()
    @State var showsSheet : Bool = false
    @State var isJoined : Bool = false
    @State var societyMembers: [SocietyMember] = []
    let societyMemberDB = SocietyMemberDB()
    @State var activities: [ActivityModel] = []
    @State var isAdmin: Bool = false
    let activityDB = ActivityDB()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Divider()
            
            Form{
                
                
                if(societyMembers.count > 0){
                    Section(header: Text("About Society"), footer: Text("status: \(society.approved ? "approved" : "pending...")")) {
                        
                        Text(society.description)
                            .font(.footnote)
                            .opacity(0.8)
                            .padding(.vertical, 5)
                        
                    }
                    
             
                    Section(header: HStack{
                        Text("Members (\(societyMembers.count))")
                        
                        Spacer()
                        
                        if(isAdmin){
                            NavigationLink {
                                ApproveMembers(society: society, user: user)
                            } label: {
                                Text("New Members")
                            }
                            .overlay(Badge(count: SocietyMemberDB().getAllForSociety(societyID: society.id, approved: false).count))
                        }
                    } ) {
                            ZStack{
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 0), count: 5), content: {
                                    ForEach(societyMembers,id:\.id){
                                    member in
                                        ZStack(alignment:.center){
                                            SocietyMemberGrid(item: member)
                                            if(member.uid == society.admin){
                                                Image(systemName: "person.circle.fill")
                                                    .offset(y: -10)
                                                    .foregroundColor(.green)
                                                    
                                            }
                                        }
                                        .blur(radius: isJoined ? 0 : 3)

                                }

                                })
                                .buttonStyle(.plain)
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

                
                if(activities.count > 0){
                    
                    Section(header: Text("Activities (\(activities.count))")) {
                        
                        ForEach(activities,id:\.id){ item in
                            ActivityRow(user: user, activity: item)
                                .disabled(isJoined ? false : true)
                    }
                }
                }else {
                    //TODO: if no activities
                }

                
                Section(header: Text("Options")) {
                  
                            HStack{
                                Spacer()
                                if(isJoined){
                                    Button {
                                        if(isAdmin){
                                            HUD.flash(.label("Admin can't leave soicety"), delay: 2)
                                        }else {
                                            societyMemberDB.delete(userID: user.id, societyId: society.id)
                                            updateView()
                                        }
                                    } label: {
                                        Text("Leave Society")
                   
                                    }
                                    .foregroundColor(Color.red)
                                }
                                else {
                                    Button {
                                        join()
                                    } label: {
                                        Text("Join Society")
                                            .fontWeight(.bold)
                                    }
                                    .foregroundColor(Color.green)
                                }

                                Spacer()
                            }
                            
                        
                }
                .opacity(isSupperAdmin(user: user) ? 0.5 : 1)
                .disabled(isSupperAdmin(user: user) ? true : false )
                
                if(isAdmin || isSupperAdmin(user: user)){
                    Section(header: Text("Admin Options"), content: {

                        HStack{
                            Spacer()
                            Button {
                                societyDB.delete(idValue: society.id)
                                societyMemberDB.delete(societyId: society.id)
                                //TODO: Maybe here need to delete all activities for activityUsers
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Delete Society")
                                    .foregroundColor(Color.red)
                            }
                            Spacer()
                        }
                        })
                }

            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showsSheet.toggle()
                    } label: { Text("Add Activity") }
                        .opacity(isAdmin ? 1 : 0)
                        .disabled(isAdmin ? false : true)
                }
            })
            .navigationTitle(society.name)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showsSheet) {
                updateView()
            } content: {
                AddActivity(user: user, society: society, societyMembers: societyMembers)
            }
            .onAppear{
                updateView()
        }
        }
        
    }
    
    func join(){
        SocietyMemberDB().add(item: SocietyMember(uid: user.id, sid: society.id, dateJoined: Date(), isApproved: false))
        updateView()
        HUD.flash(.label("Please wait for the Admin approval"), delay: 1.5)
    }
    
    func updateView(){
        //MARK: Check if the user has joined the society
        withAnimation {
            isJoined = SocietyMemberDB().isAlreadyJoined(username: user.id, societyId: society.id)
            if(isSupperAdmin(user: user)){
                isJoined = true
            }
            isAdmin = society.admin == user.id
            societyMembers = societyMemberDB.getAllForSociety(societyID: society.id, approved: true)
            activities = activityDB.getForSociety(societyId: society.id)
            
        }

    }
}



