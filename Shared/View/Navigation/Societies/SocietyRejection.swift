//
//  ActivitySummary.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/20.
//


import SwiftUI

struct SocietyRejection: View {
    let user: UserModel
    let item: SocietyModel
    @Environment(\.presentationMode) var presentationMode
    @State var content: String = ""
    var body: some View {
        VStack{
            Text("Rejection Notice")
                .font(.title)
                .padding(.top)
            
            Divider()
                .padding(10)
            
            Form{
                Section {
                    TextEditor(text: $content)
                        .frame(height: UIScreen.main.bounds.size.height / 3, alignment: .center)
                } header: {
                    Text("")
                } footer: {
                    Text(Date(), style: .date)
                }

                HStack{
                    
                    Spacer()
                    
                    Button {
                        SocietyDB().update(item: SocietyModel(id: item.id, admin: item.admin, name: item.name, description: item.description, approved: false, adminMessage: content))
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Submit")
                    }
                    
                    Spacer()
                }
            }
            
            
        }
    }
}

