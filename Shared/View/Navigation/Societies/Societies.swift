//
//  Societies.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import SwiftUI

struct Societies: View {
    let user: UserModel
    let socDB = SocietyDB()
    @State var societies : [SocietyModel] = []
    @State var showsSheet: Bool = false
    @State var updateUI: Bool = false
    @State var showMySocieties: Bool = false
    @State var showAllSocieties: Bool = false
    @State var search: String = ""
    @State var moveToSearchView: Bool = false
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink("", isActive: $moveToSearchView) {
                    Search(search: $search, searchType: .society, user: user)
                }
                TextField("Search society", text: $search)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit({
                        if(!search.isEmpty){
                            moveToSearchView.toggle()
                        }
                    })
                
                Divider()
                HStack{
                    if(user.role != "super_admin"){
                        Text("My Societies")
                        Spacer()
                        Toggle("", isOn: $showMySocieties)
                    }
                    if(user.role == "super_admin"){
                        Text("Show All Societies")
                        Spacer()
                        Toggle("", isOn: $showAllSocieties)
                    }
                }
                .padding(.horizontal)
                .onChange(of: showMySocieties) { _ in
                    updateSocieties()
                }
                .onChange(of: showAllSocieties) { _ in
                    updateSocieties()
                }
                
                Divider()
                
                if(!societies.isEmpty){
                    ScrollView{
                        ForEach(societies, id:\.id){
                            item in
                            SocietyRow(user: user, item: item, updateUI: $updateUI)
                        }
                    }
                    .onChange(of: updateUI) { _ in
                        updateSocieties()
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
                        .opacity(user.role == "super_admin" ? 0 : 1)
                        .disabled(user.role == "super_admin" ? true : false)
                }
            })
            .onAppear(){
                updateSocieties()
            }
            .sheet(isPresented: $showsSheet) {
                updateSocieties()
            } content: {
                AddSociety(user: user)
            }
            .navigationTitle("Societies")
        }
        .navigationViewStyle(.stack)

    }
    
    func updateSocieties(){
        withAnimation {
            if(user.role == "super_admin"){
                if(showAllSocieties){
                    societies = socDB.getAll().filter{ $0.approved == true }
                }else {
                    societies = socDB.getAll().filter{ $0.approved == false && $0.adminMessage == "pending"}
                }
                
            }else {
                if(showMySocieties){
                    societies = socDB.getForAdmin(user: user.id)
                }else {
                    societies = socDB.getAll().filter{ $0.approved   }
                }
              
            }
        }

    }
}

//struct Societies_Previews: PreviewProvider {
//    static var previews: some View {
//        Societies()
//    }
//}
