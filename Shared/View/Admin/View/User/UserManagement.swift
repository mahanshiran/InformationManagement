//
//  UserManagement.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/26.
//

import SwiftUI

struct UserManagement: View {
    let user: UserModel
    @State var users : [UserModel] = []
    @State var content: String = ""
    @State var search: String = ""
    @State var showCommunityUsers: Bool = false
    var body: some View {
            VStack{
                TextField("search user", text: $search)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        if(showCommunityUsers){
                            users = UserDB().getAll().filter{$0.id != "admin" && $0.id.lowercased().contains(search.lowercased()) && $0.role == "community_admin"}
                        }else {
                            users = UserDB().getAll().filter{$0.id != "admin" && $0.id.lowercased().contains(search.lowercased())}
                        }

                    }
                
                HStack{
                    Text("Show community users")
                    Spacer()
                    Toggle("", isOn: $showCommunityUsers)
                }
                .padding(.horizontal)
                .onChange(of: showCommunityUsers) { value in
                    search = ""
                    if(value){
                        users = UserDB().getAll().filter{$0.id != "admin" && $0.role == "community_admin"}
                    }else {
                        users = UserDB().getAll().filter{$0.id != "admin"}
                    }
                }
                
                Divider()
                
                List(users,id:\.id){
                    user in
                    UserRow(user: user)
                }
               
                
                Spacer()
            }
            .navigationTitle("Users management")
            .onAppear{
                users = UserDB().getAll().filter{$0.id != "admin"}
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        BatchInsertUser()
                    } label: {
                        Text("Batch Insert")
                    }

                }
            }
        

    }
}



struct UserRow: View {
    let user: UserModel
    var body: some View {
        NavigationLink(destination: OtherUser2(user: user)){
            HStack{
                Image(user.id)
                    .resizable()
                    .background(Color.gray)
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .clipShape(Circle())
                
                VStack(alignment:.leading){
                    Text(user.id)
                        .fontWeight(.heavy)
                    Text(user.name)
                        .font(.footnote)
                        .opacity(0.8)
                }
            }

        }

    }
}

