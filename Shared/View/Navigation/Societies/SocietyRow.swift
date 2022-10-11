//
//  SocietyRow.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/15.
//

import SwiftUI

struct SocietyRow: View {
    let user : UserModel
    let item: SocietyModel
    @Binding var updateUI: Bool
    @State var showReject: Bool = false
    @State var rejectText: String = ""
    var body: some View {
        
        NavigationLink(destination: Society(user: user, society: item)){
            VStack{
                if(user.role == "super_admin"){
                    adminRow()
                }else {
                    ordinaryUserView()
                }
            }
        
        }
        .disabled((!item.approved && user.role != "super_admin") ? true : false)
        .buttonStyle(.plain)
        .sheet(isPresented: $showReject) {
            updateUI.toggle()
        } content: {
            SocietyRejection(user: user, item: item)
        }

    }
    
    
    @ViewBuilder
    func adminRow() -> some View{
        HStack{
            
            VStack(alignment:.leading){
                HStack{
                    Image(item.admin)
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .clipShape(Circle())
                    VStack(alignment:.leading){
                        Text(item.admin)
                        Text(item.name)
                    }
                   
                }
                
              
                Text(item.description)
                Text("members: \(SocietyMemberDB().getAllForSociety(societyID: item.id, approved: true).count)")
                    .font(.footnote)
            }
            
            Spacer()
            
            VStack(alignment:.trailing){
                
                Text(item.adminMessage)
                    .font(.footnote)
                    .foregroundColor(item.approved ? Color.green : Color.orange)
                
                Spacer()
                
                if(!item.approved){
                    Button {
                        SocietyDB().approve(item: item)
                        if let fetchUser = UserDB().getUserWithUsername(userName: item.admin){
                            let newUser = UserModel(id: fetchUser.id, role: "community_admin", name: fetchUser.name, password: fetchUser.password, status: "normal")
                            UserDB().update(item: newUser)
                        }

                        updateUI.toggle()
                    } label: {
                        Text("approve")
                            .frame(width: 100)
                            .background(Color.green)
                            .cornerRadius(5)
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 15)
                    
                    if(user.id == item.admin || user.role == "super_admin"){
                        Button {
                            showReject.toggle()

                        } label: {
                            Text("reject")
                                .frame(width: 100)
                                .background(Color.red)
                                .cornerRadius(5)
                                
                        }
                        .buttonStyle(.plain)
                        .padding(.top, 5)
                        
                    }
                }
                
            }
            .padding(8)
            
        }
        .padding(.leading, 8)
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
        .padding(10)
    }
    
    @ViewBuilder
    func ordinaryUserView() -> some View{
        VStack{
            
            VStack(alignment: .leading){
                HStack{
                    Image(item.admin)
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading){
                        Text(item.name)
                            .fontWeight(.bold)
                        
                        Text(item.admin)
                            .font(.footnote)
                            .opacity(0.8)
                        
                    }
                   
                }
                
                Divider()
                    .padding(.horizontal)
                    .padding(.top, 5)
                
                Text(item.description)
                    .font(.footnote)
                    .opacity(0.8)
                    .lineLimit(8)
                    .padding()
                
                    
                HStack{
                    Text("\(SocietyMemberDB().getAllForSociety(societyID: item.id, approved: true).count) members")
                        .font(.footnote)
                    
                    Spacer()
                    
                    
                }
                
                if(!item.approved){
                    Divider()
                        
                    Text(item.adminMessage)
                        .font(.footnote)
                        .foregroundColor(item.adminMessage == "pending" ? Color.orange : Color.red)
                }

            }
            .padding(8)


            
        }
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
        .padding(10)
       
    }
}

//struct SocietyRow_Previews: PreviewProvider {
//    static var previews: some View {
//        SocietyRow()
//    }
//}
