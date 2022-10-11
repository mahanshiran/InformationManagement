//
//  ChangePassword.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/18.
//

import SwiftUI

struct ChangePassword: View {
    let user: UserModel
    @State var pass1: String = ""
    @State var pass2: String = ""
    var body: some View {
        Form{
            TextField("password", text: $pass1)
            TextField("re-password", text: $pass2)
            HStack{
                Spacer()
                Button {
                    //TODO: Change password
                } label: {
                    Text("Change")
                }
                
                Spacer()
            }
        }
        .navigationTitle("Change Password")
    }
}

struct ChangePassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangePassword(user: UserModel())
    }
}
