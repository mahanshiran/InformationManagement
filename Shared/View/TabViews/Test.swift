//
//  Home.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import SwiftUI

struct Test: View {
    let userDB = UserDB()
    let studentDB = StudentDB()
    let user = UserModel()
    let student = StudentModel()
    @State var users : [UserModel] = []
    @State var students : [StudentModel] = []
    @State var fields : [String] = Range(0...10).map { _ in
        return ""
    }
    var body: some View {
        NavigationView{
            Form{
//
                usersView()
                studentsView()
                

                NavigationLink("Test") {
                    TestItem(user: user)
                }
                
                
            }
            .onAppear{
                users = userDB.getAll()
                students = studentDB.getAll()
                let reflection = Mirror(reflecting: user)
                let children = reflection.children
                for child in children{
                    print("\(child.label)  \(child.value)")
                }
            }
        }


    }
    
    
    
    @ViewBuilder
    func studentsView() -> some View{
        NavigationLink("students") {
            
            VStack{
                TextField("name", text: $fields[0])
                TextField("username", text: $fields[1])
                TextField("password", text: $fields[2])
                TextField("member_of", text: $fields[3])
                
                Button {
      //              studentDB.add(item: StudentModel(id: UUID().uuidString, name: "name", username: "username", password: "pass", member_of: "memebers"))
                    studentDB.add(item: StudentModel(id: UUID().uuidString, name: fields[0], username: fields[1], password: fields[2], member_of: fields[3]))
                    students = studentDB.getAll()
                    
                } label: {
                    Text("Add Student")
                }
                .padding()
                
                ForEach(students, id:\.id){
                    student in
                    Text("\(student.name) \(student.username) \(student.password)")
                }
                Spacer()
            }
            .textFieldStyle(.roundedBorder)
            .padding()
        }
    }
    
    @ViewBuilder
    func usersView() -> some View{
        NavigationLink("users") {
            VStack{
                TextField("role", text: $fields[0])
                
                Button {
                    
                    userDB.add(item: UserModel(id: UUID().uuidString,role: "role3"))
                    users = userDB.getAll()
                    
                    
                } label: {
                    Text("Add User")
                }
                ForEach(users, id:\.id){
                    user in
                    Text(user.role)
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding()
        }
    }
}

