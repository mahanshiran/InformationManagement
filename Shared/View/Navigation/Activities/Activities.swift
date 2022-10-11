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
    @State var showFutureActivities: Bool = true
    var body: some View {
        NavigationView{
            VStack{
                Divider()
                
                HStack{
                    Text("future activities")
                    Spacer()
                    Toggle("", isOn: $showFutureActivities)
                }
                .onChange(of: showFutureActivities) { _ in
                    updateData()
                }
                .padding(.horizontal)
                
                
                if(!activities.isEmpty){
                    List(activities, id:\.id){
                        item in
                        ActivityRow(user: user, activity: item)
                    }
                }
                else{
                    Spacer()
                    Text("Empty")
                        .opacity(0.5)
                }
                
                Spacer()
                
            }
//            .toolbar(content: {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button {
//                            showsSheet.toggle()
//                        } label: { Image(systemName: "plus.circle.fill") }
//                            .opacity((user.role == "community_admin") ? 1 : 0) //MARK: if the user role is community_admin the should show the button
//                            .disabled((user.role == "community_admin") ? false : true)
//                    }
//                
//            })
            .onAppear(){
                //MARK: test it later
                updateData()
                
            }
            .sheet(isPresented: $showsSheet) {
                updateData()
            } content: {
               
            }
            .navigationTitle("Activities")

        }
        .navigationViewStyle(.stack)

    }
    
    func updateData(){
        if(showFutureActivities){
            activities = activityDB.getAll().filter({ activitty in
                activitty.date >= Date()
            })
        }else {
            activities = activityDB.getAll().filter({ activitty in
                activitty.date < Date()
            })
        }
        
    }
}

//struct Societies_Previews: PreviewProvider {
//    static var previews: some View {
//        Societies()
//    }
//}
