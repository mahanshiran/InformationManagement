//
//  Societies.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import SwiftUI

struct Activities: View {
    let user: UserModel
    let activityDB = ActivityDB()
    @State var activities : [ActivityModel] = []
    @State var showsSheet: Bool = false
    var body: some View {
        NavigationView{
            VStack{
                Divider()
                
                if(!activities.isEmpty){
                    List(activities, id:\.id){
                        item in
                        ActivityRow(item: item)
                    }
                }
                else{
                    Spacer()
                    Text("Empty")
                        .opacity(0.5)
                }
                
                Spacer()
                
            }
            .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showsSheet.toggle()
                        } label: { Image(systemName: "plus.circle.fill") }
                            .opacity(user.role == "admin" ? 1 : 0)
                            .disabled(user.role == "admin" ? false : true)
                    }
                
            })
            .onAppear(){
                //MARK: test it later
                activities = activityDB.getAll().filter({ am in
                    user.member_of.contains(am.sid)
                })
            }
            .sheet(isPresented: $showsSheet) {
                activities = activityDB.getAll()
            } content: {
               
            }
            .navigationTitle("Activities")

        }

    }
}

//struct Societies_Previews: PreviewProvider {
//    static var previews: some View {
//        Societies()
//    }
//}
