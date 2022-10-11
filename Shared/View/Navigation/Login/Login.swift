//
//  Login.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/15.
//

import SwiftUI
import PKHUD

struct Login: View {
    @State var username: String = "admin"
    @State var name: String = "mahan"
    @State var pass: String = "123456"
    @State var rePass: String = "123456"
    @State var isLoggedIn : Bool = false
    @State var user = UserModel()
    @State var isRegister: Bool = false
    @State var message: String = ""
    let userDb = UserDB()
    var body: some View {
        ZStack{
            if(isLoggedIn){
                if(user.role == "super_admin"){
                    AdminTabUIView(user: user, isLoggedIn: $isLoggedIn)
                }else {
                    UserTabUIView(user: user, isLoggedIn: $isLoggedIn)
                }
                
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
                .navigationViewStyle(.stack)
            }
        }.onAppear{
            //MARK: Insert initial Data
            userDb.add(item: UserModel(id: "admin" ,role: "super_admin", name: "Administrator", password: "123456", status: "normal"))
            userDb.batchInsert(fileName: "userData")
            
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
                        user = UserModel(id: username.lowercased() ,role: "ordinary_user", name: name, password: pass.lowercased(), status: "normal")
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
                    if(fetchedUser.id == username.lowercased() && fetchedUser.password == pass.lowercased()){
                        
                        user = UserModel(id: fetchedUser.id, role: fetchedUser.role, name: fetchedUser.name, password: fetchedUser.password, status: fetchedUser.status)
                        isLoggedIn.toggle()
                        if(user.status == "blocked"){
                            HUD.flash(HUDContentType.labeledError(title: "Warning!", subtitle: "You are blocked"), delay: 3.5)
                   
                        }
                    }
                    else {
                        
                        HUD.flash(.label("The password is incorrect!"), delay: 1.5)
                    }
                }else {
                    HUD.flash(.label("User not registered!"), delay: 1.5)
                  

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
