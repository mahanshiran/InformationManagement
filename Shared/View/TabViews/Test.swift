//
//  Home.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import SwiftUI

struct Test: View {
    let userDB = UserDB()
    let societyDB = SocietyDB()
    let recordDB = RecordDB()
    let activityDB = ActivityDB()
    let publicationDB = PublicationDB()
    let participantDB = ParticipantDB()
    
    @State var users : [UserModel] = []
    @State var societies : [SocietyModel] = []
    @State var records : [RecordModel] = []
    @State var activities : [ActivityModel] = []
    @State var publications : [PublicationModel] = []
    @State var participants : [ParticipantModel] = []
    
    @State var date : Date = Date()
    @State var fields : [String] = Range(0...10).map { _ in
        return ""
    }
    @State var boolFields : [Bool] = Range(0...10).map { _ in
        return false
    }
    
    var body: some View {
        NavigationView{
            Form{
//
                usersView()
                societiesView()
                recordsView()
                activitiesView()
                publicationsView()
                participantsView()
                
                
            }
            .onAppear{
                users = userDB.getAll()
                societies = societyDB.getAll()
                records = recordDB.getAll()
                activities = activityDB.getAll()
                publications = publicationDB.getAll()
                participants = participantDB.getAll()
            }
        }


    }
    
    
    @ViewBuilder
    func usersView() -> some View{
        NavigationLink("users") {
            VStack{
                
                TextField("role", text: $fields[0])
                TextField("name", text: $fields[1])
                TextField("username", text: $fields[2])
                TextField("password", text: $fields[3])
                TextField("member_of", text: $fields[4])
                
                Button {
                    
                    userDB.add(item: UserModel(id: UUID().uuidString, role: fields[0], name: fields[1], username: fields[2], password: fields[3], member_of: fields[4]))
                    users = userDB.getAll()
                    
                } label: {
                    Text("Add User")
                }
                
                Spacer()
                
                List(users, id:\.id){
                    user in
                    HStack{
                        VStack{
                            Text(user.role)
                            Text(user.name)
                            Text(user.username)
                            Text(user.password)
                            Text(user.member_of)
                            
                        }
                        
                        
                        Spacer()
                        
                        Button {
                            userDB.delete(idValue: user.id)
                            users = userDB.getAll()
                        } label: {
                            Image(systemName: "trash")
                        }

                    }
                  
                    
                }
                
                Spacer()
            }
            .navigationTitle("User")
            .textFieldStyle(.roundedBorder)
            .padding()
        }
    }
    
    @ViewBuilder
    func societiesView() -> some View{
        NavigationLink("societies") {
            VStack(alignment: .center){
                
                TextField("admin", text: $fields[0])
                TextField("name", text: $fields[1])
                TextField("description", text: $fields[2])
                Toggle("approved?", isOn: $boolFields[0])
                
                Button {
                    
                    societyDB.add(item: SocietyModel(id: UUID().uuidString, admin: fields[0], name: fields[1], description: fields[2], approved: boolFields[0]))
                    societies = societyDB.getAll()
                    
                } label: {
                    Text("Add User")
                }
                
                Spacer()
                
                List(societies, id:\.id){
                    item in
                    HStack{
                        
                        VStack(alignment: .leading){
                            Text("admin: \(item.admin)")
                            Text("name: \(item.name)")
                            Text("des: \(item.description)")
                            Image(systemName: item.approved ? "checkmark.square.fill" : "square")
                        }
                        
                        Spacer()
                        
                        Button {
                            societyDB.delete(idValue: item.id)
                            societies = societyDB.getAll()
                        } label: {
                            Image(systemName: "trash")
                        }

                    }
                  
                    
                }
                
                Spacer()
            }
            .navigationTitle("Society")
            .textFieldStyle(.roundedBorder)
            .padding()
        }
    }
    
    
    @ViewBuilder
    func recordsView() -> some View{
        NavigationLink("records") {
            VStack(alignment: .center){
                
                TextField("members", text: $fields[0])
                TextField("activities", text: $fields[1])
                TextField("publications", text: $fields[2])
                TextField("members_deleted", text: $fields[3])
                TextField("activities_deleted", text: $fields[4])
                TextField("engagement", text: $fields[5])
                DatePicker("date_created", selection: $date)
                
                Button {
                    
                    recordDB.add(item: RecordModel(id: UUID().uuidString, members: Int(fields[0]) ?? 0, activities: Int(fields[0]) ?? 0, publications: Int(fields[0]) ?? 0, members_deleted: Int(fields[0]) ?? 0, activities_deleted: Int(fields[0]) ?? 0, engagement: Double(Int(fields[0]) ?? 0), date_created: date))
                    records = recordDB.getAll()
                    
                } label: {
                    
                    Text("Add Record")
                }
                
                Spacer()
                
                List(records, id:\.id){
                    item in
                    HStack{
                        
                        VStack(alignment: .leading){
                            Text("activities: \(item.activities)")
                            Text("activities: \(item.activities)")
                            Text("publications: \(item.publications)")
                            Text("members_deleted: \(item.members_deleted)")
                            Text("activities_deletedd: \(item.activities_deleted)")
                            Text("engagement: \(item.engagement)")
                            Text("date_created: \(item.date_created)")
                            
                        }
                        
                        Spacer()
                        
                        Button {
                            recordDB.delete(idValue: item.id)
                            records = recordDB.getAll()
                        } label: {
                            Image(systemName: "trash")
                        }

                    }
                  
                    
                }
                
             
            }
            .navigationTitle("Records")
            .textFieldStyle(.roundedBorder)
            .padding()
        }
    }
    
    @ViewBuilder
    func activitiesView() -> some View{
        NavigationLink("activities") {
            VStack(alignment: .center){
                
                TextField("sid(foreign)", text: $fields[0])
                TextField("title", text: $fields[1])
                TextField("name", text: $fields[2])
                TextField("description", text: $fields[3])
                TextField("status", text: $fields[4])
                DatePicker("date", selection: $date)
                
                Button {
                    
                    activityDB.add(item: ActivityModel(id: UUID().uuidString, sid: fields[0], title: fields[1], name: fields[2], description: fields[3], status: fields[4], date: date))
                    activities = activityDB.getAll()
                    
                } label: {
                    
                    Text("Add Activity")
                }
                
                Spacer()
                
                List(activities, id:\.id){
                    item in
                    HStack{
                        
                        VStack(alignment: .leading){
                            Text("sid: \(item.sid)")
                            Text("title: \(item.title)")
                            Text("name: \(item.name)")
                            Text("description: \(item.description)")
                            Text("status: \(item.status)")
                            Text("date: \(item.date)")
                            
                        }
                        
                        Spacer()
                        
                        Button {
                            activityDB.delete(idValue: item.id)
                            activities = activityDB.getAll()
                        } label: {
                            Image(systemName: "trash")
                        }

                    }
                  
                    
                }
                
             
            }
            .navigationTitle("Activities")
            .textFieldStyle(.roundedBorder)
            .padding()
        }
    }
    
    
    @ViewBuilder
    func publicationsView() -> some View{
        NavigationLink("publications") {
            VStack(alignment: .center){
                
                TextField("aid(foreign)", text: $fields[0])
                TextField("uid(foreign)", text: $fields[1])
                TextField("content", text: $fields[2])
                Toggle("modifiable", isOn: $boolFields[0])
                DatePicker("date", selection: $date)
                
                Button {
                    
                    publicationDB.add(item: PublicationModel(id: UUID().uuidString, aid: fields[0], uid: fields[1], content: fields[2], modifiable: boolFields[0], date: date))
                    publications = publicationDB.getAll()
                    
                } label: {
                    
                    Text("Add Publication")
                }
                
                Spacer()
                
                List(publications, id:\.id){
                    item in
                    HStack{
                        
                        VStack(alignment: .leading){
                            
                            Text("aid: \(item.aid)")
                            Text("uid: \(item.uid)")
                            Text("content: \(item.content)")
                            Image(systemName: item.modifiable ? "checkmark.square.fill" : "square")
                            Text("date: \(item.date)")
                            
                        }
                        
                        Spacer()
                        
                        Button {
                            publicationDB.delete(idValue: item.id)
                            publications = publicationDB.getAll()
                        } label: {
                            Image(systemName: "trash")
                        }

                    }
                  
                    
                }
                
             
            }
            .navigationTitle("publications")
            .textFieldStyle(.roundedBorder)
            .padding()
        }
    }
    
    @ViewBuilder
    func participantsView() -> some View{
        NavigationLink("participants") {
            VStack(alignment: .center){
                
                TextField("aid (Foreign))", text: $fields[0])
                
                Button {
                    participantDB.add(item: ParticipantModel(id: UUID().uuidString, aid: fields[0]))
                    participants = participantDB.getAll()
                    
                } label: {
                    
                    Text("Add Pariticipant")
                }
                
                Spacer()
                
                List(participants, id:\.id){
                    item in
                    HStack{
                        
                        VStack(alignment: .leading){
                            
                            Text("aid: \(item.aid)")
                            
                        }
                        
                        Spacer()
                        
                        Button {
                            participantDB.delete(idValue: item.id)
                            participants = participantDB.getAll()
                        } label: {
                            Image(systemName: "trash")
                        }

                    }
                  
                    
                }
                
             
            }
            .navigationTitle("participants")
            .textFieldStyle(.roundedBorder)
            .padding()
        }
    }
    
}

