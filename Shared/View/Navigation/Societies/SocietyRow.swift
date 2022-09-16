//
//  SocietyRow.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/15.
//

import SwiftUI

struct SocietyRow: View {
    let item: SocietyModel
    var body: some View {
        VStack(alignment: .leading){
            Text("admin: \(item.admin)")
            Text("name: \(item.name)")
            Text("des: \(item.description)")
            Image(systemName: item.approved ? "checkmark.square.fill" : "square")
            
        }
    }
}

//struct SocietyRow_Previews: PreviewProvider {
//    static var previews: some View {
//        SocietyRow()
//    }
//}
