//
//  AddSociety.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/15.
//

import SwiftUI
import PKHUD

struct AddSociety: View {
    
    let user: UserModel
    let societyDB = SocietyDB()
    
    @State var date : Date = Date()
    @Environment(\.presentationMode) var presentationMode
    @State var fields : [String] = Range(0...10).map { _ in
        return ""
    }
    @State var boolFields : [Bool] = Range(0...10).map { _ in
        return false
    }
    
    var body: some View {
        VStack(alignment: .center){
            Text("Add Society")
                .font(.title)
                .padding(.top)
            
            Form{
                Section {
                    TextField("name", text: $fields[0])
                    TextField("description", text: $fields[1])
                    //Toggle("approved?", isOn: $boolFields[0])
                    
                    

                    
                    
                    HStack{
                        Spacer()
                        Button {
                            if(user.status == "blocked"){
                                HUD.flash(.label("You are blocked, please contact admin"), delay: 1.5)
                            }else{
                                //TODO: Check if the fields are valid
                                let societyID = UUID().uuidString
                                societyDB.add(item: SocietyModel(id: societyID, admin: user.id, name: fields[0], description: fields[1], approved: false, adminMessage: "pending"))
                                SocietyMemberDB().add(item: SocietyMember(uid: user.id, sid: societyID, dateJoined: Date(), isApproved: true))
                                presentationMode.wrappedValue.dismiss()
                                HUD.flash(.label("Please wait for admin approval"), delay: 2)
                            }

                        } label: {
                            Text("Add Society")
                        }
                        Spacer()
                    }

                } header: {
                    Text("Admin: " + user.id)
                }

            }
           
//                .textFieldStyle(.roundedBorder)
            //.padding()
            }
       
    }
    
    

}
//
//struct AddSociety_Previews: PreviewProvider {
//    static var previews: some View {
//        AddSociety()
//    }
//}
