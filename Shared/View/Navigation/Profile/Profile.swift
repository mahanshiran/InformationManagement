//
//  Profile.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import SwiftUI

struct Profile: View {
    let user: UserModel
    @Binding var isLoggedIn : Bool
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
                
                Image(user.id)
                    .resizable()
                    .background(Color.gray)
                    .scaledToFit()
                    .frame(width: 150, height: 150, alignment: .center)
                    .clipShape(Circle())
                    .padding()
                
                if(editProfile){ //MARK: if this is true then shows editing view
                    editProfileView()
                        .padding()
                }else {
                    profileView()
                        .padding()
                }
                Spacer()
                
                Form{
                    NavigationLink(destination: ChangePassword(user: user)) {
                        Text("Change Password")
                    }
                    if(user.role != "super_admin"){
                        NavigationLink(destination: JoinedSocieties(user: user)){
                            Text("Societies")
                        }
                        NavigationLink(destination: JoinedActivities(user: user)){
                            Text("Activities")
                        }
                        NavigationLink(destination: AllComments(user: user, passedUser: user, activity: nil)){
                            Text("Comments")
                        }
                    }
                }
                
                Spacer()
                
            }
            
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isLoggedIn.toggle()
                    } label: {
                        Text("Logout")
                            .foregroundColor(.red)
                    }

                }
                editProfile ?
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        //TODO: Update Profile
                        let newUser = UserModel(id: user.id, role: user.role, name: fields[2], password: fields[3], status: "normal")
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
                fields[0] = user.id
                fields[1] = user.role
                fields[2] = user.name
                fields[3] = user.password
            }
        }
        .navigationViewStyle(.stack)
        
    }
    
    
    @ViewBuilder
    func editProfileView() -> some View{
        VStack{
            TextField("username", text: $fields[0])
            TextField("name", text: $fields[2])
            //TextField("password", text: $fields[3])
            
        }
        .textFieldStyle(.roundedBorder)
        
    }
    
    
    @ViewBuilder
    func profileView() -> some View{
        VStack(spacing: 7){
            Text("name: " + user.name)
            Text("username: " + user.id)
            Text("status: " + user.status)
            
            //Text(user.password)
        }
        .opacity(0.8)
    }
    
    
}

//struct Profile_Previews: PreviewProvider {
//    static var previews: some View {
//        Profile()
//    }
//}
