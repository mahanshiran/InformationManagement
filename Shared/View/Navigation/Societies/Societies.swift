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
    var body: some View {
        NavigationView{
            VStack{
                
                Divider()
                
                if(!societies.isEmpty){
                    List(societies, id:\.id){
                        item in
                        SocietyRow(item: item)
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
                }
            })
            .onAppear(){
                societies = socDB.getAll()
            }
            .sheet(isPresented: $showsSheet) {
                societies = socDB.getAll()
            } content: {
                AddSociety(user: user)
            }
            .navigationTitle("Societies")

        }

    }
}

//struct Societies_Previews: PreviewProvider {
//    static var previews: some View {
//        Societies()
//    }
//}
