//
//  testItem.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import SwiftUI

struct TestItem<T>: View {
    let user : T
    @State var items : [T] = []
    @State var fields : [String] = Range(0...10).map { _ in
        return ""
    }
    
    var body: some View {
        VStack{
            let mirror = Mirror(reflecting: user)
            ForEach(Array(mirror.children).indices, id:\.self){ i in
                TextField("\(Array(mirror.children)[i].label!)", text: $fields[i])
            }
                
        }
        .textFieldStyle(.roundedBorder)
        .padding()
        .onAppear{
            if T.self is StudentModel{
                print("StudentModel")
            }else if T.self is UserModel{
                print("User")
            }
            else {
                print("Other")
            }

//            if T.self is StudentModel{
//                items as! StudentModel = StudentDB().getAll()
//            }
            
            
        }
    }
    
}

