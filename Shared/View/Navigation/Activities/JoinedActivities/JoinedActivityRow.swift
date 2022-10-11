//
//  JoinedActivityRow.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/18.
//

import SwiftUI

struct JoinedActivityRow: View {
    let item: ActivityMember
    let user: UserModel
    @State var activity: ActivityModel = ActivityModel()
    @State var admin: UserModel = UserModel()
    @State var seenActivities : [String] = []
    var body: some View {
        NavigationLink(destination: Activity(user: user, activity: activity)){
            
            VStack(alignment: .leading){
                
                HStack{
                    Image(activity.creator)
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading){
                        Text(activity.name)
                            .fontWeight(.bold)
                        
                        Text(activity.creator)
                            .font(.footnote)
                            .opacity(0.8)
                        
                    }
                    
                    Spacer()
                    if(!seenActivities.contains(activity.id)){
                        Circle()
                            .frame(width: 10, height: 10, alignment: .center)
                            .foregroundColor(Color.green)
                    }
                   
                }
                Divider()
                    .padding(.horizontal)
                    .padding(.top, 5)
                
                Text(activity.description)
                    .font(.footnote)
                    .opacity(0.8)
                    .lineLimit(8)
                    .padding()

                HStack{
                    Spacer()
                    if(activity.date < Date()){
                        Text("Already finished")
                            .font(.footnote)
                            .foregroundColor(Color.orange)
                    }else{
                        Text(activity.date, style: .date)
                            .font(.footnote)
                            .opacity(0.5)
                    }

                }

            }
            .padding(8)
            
            
        }
        
        .onAppear{
            activity = ActivityDB().getAll().filter({ a in
                a.id == item.aid
            }).first ?? ActivityModel()
            
            admin = UserDB().getUserWithUsername(userName: activity.creator) ?? UserModel()
            seenActivities = UserDefaults.standard.stringArray(forKey: "seenActivities") ?? []
        }
        .frame(width: UIScreen.main.bounds.width / 1.05, alignment: .leading)
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
        .buttonStyle(.plain)
        .padding(.vertical, 5)
        
    }
}


