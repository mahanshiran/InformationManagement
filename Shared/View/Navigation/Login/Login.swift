//
//  Login.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/15.
//

import SwiftUI

struct Login: View {
    @State var username: String = "mahanshiran"
    @State var name: String = "mahan"
    @State var pass: String = "123456"
    @State var rePass: String = "123456"
    @State var isLoggedIn : Bool = false
    @State var user = UserModel()
    @State var isRegister: Bool = false
    @State var message: String = ""
    let userDb = UserDB()
    var body: some View {
        if(isLoggedIn){
            
            TabUIView(user: user)
            
        }else{
            
            NavigationView{
                VStack{
                    if(isRegister){
                        registerView()
                    }else {
                        loginView()
                    }
                }
                .textFieldStyle(.roundedBorder)
                .padding()
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isRegister.toggle()
                        } label: {
                            Text(isRegister ? "Have an account?" : "Register")
                        }
                    }
                })

            }


        }

    }
    
    @ViewBuilder
    func registerView()-> some View{
        VStack{
            TextField("username", text: $username)
            
            TextField("name", text: $name)
            
            SecureField("password", text: $pass)
            
            SecureField("re-password", text: $rePass)
            
            Text(message)
                .font(.footnote)
                .frame(height: 50, alignment: .center)
                .foregroundColor(Color.red)
            
            
            Button {
                //TODO: Check if register is OK
                if(!name.isEmpty && !username.isEmpty && !pass.isEmpty && (pass == rePass)){//MARK: If fields are ok...
                    
                    //MARK: Check if username does not exist, create one and toggle back to login
                    if userDb.getUserWithUsername(userName: username) == nil{
                        user = UserModel(role: "", name: name, username: username.lowercased(), password: pass.lowercased(), member_of: "")
                        userDb.add(item: user)
                        isRegister = false
                    }
                    else { //MARK: Check if username already exists
                        message = "a user with this username already exists! "
                    }
                    

                }
                
            } label: {
                Text("Register")
            }
        }
    }
    
    
    @ViewBuilder
    func loginView()-> some View{
        VStack{
            TextField("username", text: $username)
            
            SecureField("password", text: $pass)
            
            Text(message)
                .font(.footnote)
                .frame(height: 50, alignment: .center)
                .foregroundColor(Color.red)
            
            Button {
                //MARK: Check if user is in database
                if let fetchedUser = userDb.getUserWithUsername(userName: username.lowercased()){
                    
                    //MARK: Check username and password Integrity
                    if(fetchedUser.username == username.lowercased() && fetchedUser.password == pass.lowercased()){
                        
                        user = UserModel(role: fetchedUser.role, name: fetchedUser.name, username: fetchedUser.username, password: fetchedUser.password, member_of: fetchedUser.member_of)
                        isLoggedIn.toggle()
                    }
                    else {
                        message = "The password is incorrect!"
                    }
                }else {
                    message = "User not registered!"

                }

            } label: {
                Text("Login")
            }
        }

    }
    
}


//struct Login_Previews: PreviewProvider {
//    static var previews: some View {
//        Login(tab: <#Binding<Tab>#>)
//    }
//}
