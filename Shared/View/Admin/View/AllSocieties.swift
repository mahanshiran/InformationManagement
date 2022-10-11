//
//  UserManagement.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/26.
//

import SwiftUI

struct AllSocieties: View {
    let user: UserModel
    @State var items : [SocietyModel] = []
    @State var search: String = ""
    @State var update: Bool = false
    var body: some View {
            VStack{
                TextField("search Society", text: $search)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        if(search.isEmpty){
                            items = SocietyDB().getAll()
                        }else {
                            items = SocietyDB().getAll().filter{$0.name.lowercased().contains(search.lowercased())}
                        }

                    }
                Divider()
                
                ScrollView{
                    ForEach(items,id:\.id){
                        item in
                        SocietyRow(user: user, item: item, updateUI: $update)
                    }
                }

                Spacer()
            }
            .navigationTitle("All Societies")
            .onAppear{
                items = SocietyDB().getAll()
            }
            .toolbar {

            }
        

    }
}

