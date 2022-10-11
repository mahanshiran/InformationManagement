//
//  Search.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/23.
//

import SwiftUI

enum SearchType{
    case activity, society, user
}

struct Search: View {
    @Binding var search: String
    let searchType: SearchType
    let user: UserModel
    @State var activities: [ActivityModel] = []
    @State var users: [UserModel] = []
    @State var societies: [SocietyModel] = []
    @State var update: Bool = false
    var body: some View {
        VStack{
            TextField("Search", text: $search)
                .textFieldStyle(.roundedBorder)
                .onChange(of: search) { _ in
                    resetSearch()
                }
          
                
            
            if(searchType == .activity){
                List(activities, id:\.id) { item in
                    ActivityRow(user: user, activity: item)
                }
            }
            else if(searchType == .society){
                ForEach(societies, id:\.id) { item in
                   SocietyRow(user: user, item: item, updateUI: $update)
                }
            }
//            else if(searchType = .user){
//                List(users, id:\.id) { item in
//
//                }
//            }
            Spacer()
            
        }
        .navigationTitle("Search")
        .onAppear{
            resetSearch()
        }
     
    }
    
    func resetSearch(){
        if(searchType == .activity){
            activities = ActivityDB().getAll().filter({ a in
                a.name.lowercased().contains(search.lowercased()) || a.creator.lowercased().contains(search.lowercased())
            })
        }
        else if(searchType == .user){
            users = UserDB().getAll().filter({ a in
                a.name.lowercased().contains(search.lowercased()) || a.id.contains(search.lowercased())
            })
        }
        else if(searchType == .society){
            societies = SocietyDB().getAll().filter({ a in
                a.name.lowercased().contains(search.lowercased()) || a.admin.contains(search.lowercased())
            })
        }
    }
}

