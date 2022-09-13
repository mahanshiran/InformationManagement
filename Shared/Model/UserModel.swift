//
//  UserModel.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import Foundation

protocol ss {
    func D()
}

struct UserModel: Identifiable, Codable, Equatable {

    
    public var id : String = ""
    public var role : String = "" //'super_admin', 'community_admin', 'ordinary_user'
    
    init(){}
        
    init (role: String){
        self.role = role;
    }
    
    init (id : String,role:String){
        self.id = id;
        self.role = role;
    }
    
}

