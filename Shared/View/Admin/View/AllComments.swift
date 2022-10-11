//
//  UserManagement.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/26.
//

import SwiftUI

struct AllComments: View {
    let user: UserModel
    let passedUser: UserModel?
    let activity: ActivityModel?
    @State var items : [PublicationModel] = []
    @State var search: String = ""
    @State var updateView = false
    var body: some View {
            VStack{
                TextField("search Comment", text: $search)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        if(search.isEmpty){
                            items = PublicationDB().getAll()
                        }else {
                            if let passedUser = passedUser {
                                items = PublicationDB().getAll().filter{$0.uid == passedUser.id && $0.content.lowercased().contains(search.lowercased())}
                            }
                            if let activity = activity {
                                items = PublicationDB().getAll().filter{$0.aid == activity.id && $0.content.lowercased().contains(search.lowercased())}
                            }
                            if(passedUser == nil && activity == nil){
                                items = PublicationDB().getAll().filter{$0.content.lowercased().contains(search.lowercased())}
                            }
                        }

                    }
                Divider()
                
                ForEach(items,id:\.id){
                    item in
                    //TODO: add custom struct
                    CommentRow(user: user, comment: item, updateView: $updateView)
                }
               
                
                Spacer()
            }
            .onChange(of: updateView, perform: { _ in
                getData()
            })
            .navigationTitle("All Comments")
            .onAppear{
                getData()
            }
            .toolbar {

            }
        

    }
    
    func getData(){
        if let user = passedUser {
            items = PublicationDB().getAll().filter{$0.uid == user.id}
        }
        if let activity = activity {
            items = PublicationDB().getAll().filter{$0.aid == activity.id}
        }
        if(passedUser == nil && activity == nil){
            items = PublicationDB().getAll()
        }
    }
}

