//
//  BatchInsertUser.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/27.
//

import SwiftUI
import PKHUD

struct BatchInsertUser: View {
    @State var text: String = ""
    @State var users : [UserModel] = []
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Form{
            Section(header: Text("Batch insert users(seperated by comma',')")) {
                TextEditor(text: $text)
                    .frame(height: 200, alignment: .center)
                    .onChange(of: text) { value in
                        users.removeAll()
                        let userRaw = text.components(separatedBy: ",")
                        
                        for username in userRaw{
                            users.append(UserModel(id: username, role: "oridinary_user", name: "", password: "123456", status: "normal"))
                        }
                    }


            }
            Section(header: Text("\(users.count) users")) {
                HStack{
                    Spacer()
                    Button {
                        for u in users{
                            if(!u.id.isEmpty){
                                UserDB().add(item: u)
                            }
                        }
                        
                        HUD.flash(.label("users added"),delay: 1)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                    } label: {
                        Text("Add Users")
                    }
                    Spacer()
                }
            }

            
            List(users, id:\.id){
                u in
                Text(u.id)
            }

        }

        .navigationTitle("Batch Insert User")
    }
}

