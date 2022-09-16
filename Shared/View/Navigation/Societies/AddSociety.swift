//
//  AddSociety.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/15.
//

import SwiftUI

struct AddSociety: View {
    
    let user: UserModel
    let societyDB = SocietyDB()
    @State var date : Date = Date()
    @State var fields : [String] = Range(0...10).map { _ in
        return ""
    }
    @State var boolFields : [Bool] = Range(0...10).map { _ in
        return false
    }
    
    var body: some View {
        VStack{
            societiesView()
        }
    }
    
    
    
    @ViewBuilder
    func societiesView() -> some View{
            VStack(alignment: .center){
                
                Text(user.username)
                TextField("name", text: $fields[0])
                TextField("description", text: $fields[1])
                Toggle("approved?", isOn: $boolFields[0])
                
                Button {
                    
                    societyDB.add(item: SocietyModel(id: UUID().uuidString, admin: user.username, name: fields[1], description: fields[2], approved: boolFields[0]))
//                    societies = societyDB.getAll()
                    
                } label: {
                    Text("Add User")
                }
                
                Spacer()
                
            }
            .navigationTitle("Society")
            .textFieldStyle(.roundedBorder)
            .padding()
        
    }
}
//
//struct AddSociety_Previews: PreviewProvider {
//    static var previews: some View {
//        AddSociety()
//    }
//}
