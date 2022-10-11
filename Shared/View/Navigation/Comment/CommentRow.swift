//
//  CommentRow.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/27.
//

import SwiftUI

struct CommentRow: View {
    let user: UserModel
    let comment: PublicationModel
    @Binding var updateView: Bool
    @State var fetchedUser: UserModel = UserModel()
    @State var activity: ActivityModel = ActivityModel()
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                HStack{
                    Image(fetchedUser.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                        .clipShape(Circle())
                    
                    Text(fetchedUser.id)
                        .font(.footnote)
                    
                }
                .opacity(0.8)
                
                Spacer()
                
                Text(comment.date, style: .date)
                    .font(.footnote)
                    .opacity(0.8)
            }
            
            Divider()
                .padding(.bottom, 5)

            Text(comment.content)
                .font(.footnote.bold())
                .padding()
            
            Divider()
                .padding(.top, 5)
            
            HStack{
                Text("Activity: " + activity.name)
                    .font(.footnote)
                    .opacity(0.7)
                
                Spacer()
                
                if(isSupperAdmin(user: user) || (user.id == fetchedUser.id)){
                    Button {
                        PublicationDB().delete(idValue: comment.id)
                        updateView.toggle()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(Color.red)
                            .font(.footnote)
                    }

                }

            }

        }
        .padding(8)
        .background(Color.white.opacity(0.1))
        .frame(width: UIScreen.main.bounds.width / 1.05, alignment: .center)
        .cornerRadius(10)
        .onAppear{
            fetchedUser = UserDB().getUserWithUsername(userName: comment.uid) ?? UserModel()
            activity = ActivityDB().getById(aid: comment.aid).first ?? ActivityModel()
        }
    }
}


