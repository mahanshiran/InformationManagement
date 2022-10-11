//
//  AddActivity.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/18.
//

import SwiftUI
import PKHUD

struct AddActivity: View {
    let user: UserModel
    let society: SocietyModel
    @State var societyMembers: [SocietyMember] = []
    @State var tempSocietyMembers: [SocietyMember] = []
    let activityDB = ActivityDB()
    @State var date : Date = Date()
    @Environment(\.presentationMode) var presentationMode
    @State var fields : [String] = Range(0...10).map { _ in
        return ""
    }
    @State var boolFields : [Bool] = Range(0...10).map { _ in
        return false
    }
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                Text("Add Activity")
                    .font(.title)
                    .padding(.top)
                
                Form{
                    Section {
                        TextField("name", text: $fields[1])
                        TextField("description", text: $fields[2])
                        DatePicker("Date", selection: $date, in: Date()...)
                        

                    } header: {
                        Text("Basic Info" + society.name)
                    }
                    
                    Section {
                        NavigationLink {
                            AddActivityMember(society: society, societyMembers: $societyMembers, tempSocietyMembers: $tempSocietyMembers)
                        } label: {
                            Text("Invite society members")
                        }
                        
                        if(!tempSocietyMembers.isEmpty){
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 0), count: 5), content: {
                              
                                    ForEach(tempSocietyMembers,id:\.id){
                                        member in
                                            SocietyMemberGrid(item: member)
                                    }
                            })
                        }
                        
                    } header: {
                        Text("Members")
                    }
                    
                    
                    HStack{
                        Spacer()
                        Button {
                            if(user.status == "blocked"){
                                HUD.flash(.label("You are blocked, please contact admin"), delay: 1.5)
                            }else{
                                //TODO: Check if the fields are valid
                                let activityID = UUID().uuidString
                                activityDB.add(item: ActivityModel(id: activityID, sid: society.id, creator: user.id, name: fields[1], description: fields[2], status: "Not Started", date: date))
                                ActivityMemberDB().add(item: ActivityMember(id: UUID().uuidString, uid: user.id, aid: activityID, dateJoined: Date(), isApproved: true))
                                
                                for member in tempSocietyMembers{
                                    ActivityMemberDB().add(item: ActivityMember(id: UUID().uuidString, uid: member.uid, aid: activityID, dateJoined: Date(), isApproved: true))
                                    
                                }
                                presentationMode.wrappedValue.dismiss()
                                HUD.flash(.label("Activity Created"), delay: 1.5)
                            }

                            
                        } label: {
                            Text("Add Activity")
                        }
                        Spacer()
                    }
                }

                }
            .onAppear{
                societyMembers = SocietyMemberDB().getAllForSociety(societyID: society.id, approved: true)
            }
            .navigationBarHidden(true)
        }
    }
    }


struct AddActivityMember: View {
    let society: SocietyModel
    @Binding var societyMembers: [SocietyMember]
    @Binding var tempSocietyMembers: [SocietyMember]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{

            Divider()
            
            
            
            Text("Click on the icon to invite")
                .font(.footnote)
                .padding()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 0), count: 5), content: {
                ForEach(societyMembers.filter{!tempSocietyMembers.contains($0) && $0.uid != society.admin},id:\.id){
                    member in
                        SocietyMemberGrid(item: member)
                        .onTapGesture {
                            tempSocietyMembers.append(member)
                            societyMembers.removeAll { a in
                                a.id == member.id
                            }
                        }

                }

            })
            .padding(.top,15)
            
            Spacer()
        }
        .navigationTitle("Invite Members")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                }

            }
        }
    }
}
