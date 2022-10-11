//
//  JoinedSocietyRow.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/17.
//

import SwiftUI

struct JoinedSocietyRow: View {
    let item: SocietyMember
    let user: UserModel
    @State var updateView = false
    @State var society: SocietyModel = SocietyModel()
    var body: some View {
            
        SocietyRow(user: user, item: society, updateUI: $updateView)
        
        .onAppear{
            society = SocietyDB().getAll().filter({ s in
                s.id == item.sid
            }).first ?? SocietyModel()
        }
        
    }
}

