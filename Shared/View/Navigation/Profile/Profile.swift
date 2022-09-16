//
//  Profile.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import SwiftUI

struct Profile: View {
    let user: UserModel
    @State var editProfile : Bool = false
    @State var date : Date = Date()
    @State var fields : [String] = Range(0...10).map { _ in
        return ""
    }
    @State var boolFields : [Bool] = Range(0...10).map { _ in
        return false
    }
    
    var body: some View {
        NavigationView{
            
            VStack{
                Divider()
                
                if(editProfile){ //MARK: if this is true then shows editing view
                    editProfileView()
                        .padding()
                }else {
                    profileView()
                        .padding()
                }
                Spacer()
                
            }
            
            .navigationTitle("Profile")
            .toolbar {
                editProfile ?
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        //TODO: Update Profile
                        let newUser = UserModel(id: user.id, role: user.role, name: fields[1], username: fields[2], password: fields[3], member_of: fields[4])
                        UserDB().update(item: newUser)
                        withAnimation {
                            editProfile.toggle()
                        }
                      
                    } label: {
                        Text("Save")
                    }
                   
                }
                :
                ToolbarItem(placement: .navigationBarTrailing){
                    
                    Button {
                        withAnimation {
                            editProfile.toggle()
                        }
                    } label: {
                        Text("Edit")
                    }
                    
                }
                
            }
            .onAppear{
                fields[0] = user.role
                fields[1] = user.name
                fields[2] = user.username
                fields[3] = user.password
                fields[4] = user.member_of
            }
        }
        
    }
    
    
    @ViewBuilder
    func editProfileView() -> some View{
        VStack{
            TextField("role", text: $fields[0])
            TextField("name", text: $fields[1])
            TextField("username", text: $fields[2])
            TextField("password", text: $fields[3])
            TextField("member_of", text: $fields[4])
            
        }
        .textFieldStyle(.roundedBorder)
        
    }
    
    
    @ViewBuilder
    func profileView() -> some View{
        VStack{
            Text(user.role)
            Text(user.name)
            Text(user.username)
            Text(user.password)
            Text(user.member_of)
        }
    }
    
    
}

//struct Profile_Previews: PreviewProvider {
//    static var previews: some View {
//        Profile()
//    }
//}
