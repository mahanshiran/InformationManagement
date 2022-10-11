//
//  UserManagement.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/26.
//

import SwiftUI

struct AllActivities: View {
    let user: UserModel
    @State var items : [ActivityModel] = []
    @State var search: String = ""
    @State var sDate : Date = Date()
    @State var eDate : Date = Date()
    var body: some View {
            VStack{
                TextField("search Society", text: $search)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        if(search.isEmpty){
                            items = ActivityDB().getAll()
                        }else {
                            items = ActivityDB().getAll().filter{$0.name.lowercased().contains(search.lowercased())}
                        }

                    }
                
                HStack{
                        DatePicker("From", selection: $sDate, displayedComponents: .date)
                        
                    DatePicker("To", selection: $eDate, displayedComponents: .date).padding(.leading)
                    Button {
                        items = ActivityDB().getAll(sDate: sDate, eDate: eDate)
                    } label: {
                        Text("Get")
                    }

                }

                Divider()
                
                List(items,id:\.id){
                    item in
                    ActivityRow(user: user, activity: item)
                }
               
                
                Spacer()
            }
            .navigationTitle("All Activities")
            .onAppear{
                items = ActivityDB().getAll()
            }
            .toolbar {

            }
        

    }
}

