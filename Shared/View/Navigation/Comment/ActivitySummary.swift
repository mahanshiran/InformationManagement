//
//  ActivitySummary.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/20.
//


import SwiftUI
import PKHUD

struct ActivitySummary: View {
    let user: UserModel
    let activity: ActivityModel
    @Environment(\.presentationMode) var presentationMode
    @State var content: String = ""
    var body: some View {
        VStack{
            Text("Write Summary")
                .font(.title)
                .padding(.top)
            
            Divider()
                .padding(10)
            
            Form{
                Section {
                    TextEditor(text: $content)
                        .frame(height: UIScreen.main.bounds.size.height / 3, alignment: .center)
                } header: {
                    Text("Sender: " + user.id)
                } footer: {
                    Text(Date(), style: .date)
                }

                HStack{
                    
                    Spacer()
                    
                    Button {
                        if(user.status == "blocked"){
                            HUD.flash(.label("You are blocked, please contact admin"), delay: 1.5)
                        }else{
                            PublicationDB().add(item: PublicationModel(id: UUID().uuidString,aid: activity.id, uid: user.id, content: content, modifiable: true, date: Date()))
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("Submit")
                    }
                    
                    Spacer()
                }
            }
            
            
        }
    }
}

