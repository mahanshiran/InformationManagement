//
//  UserModel.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import Foundation


struct UserModel: Identifiable, Codable, Equatable {

    
    public var id : String = ""
    public var role : String = "" //'super_admin', 'community_admin', 'ordinary_user'
    public var name : String = ""
    public var password : String = ""
    public var status : String = ""
    
    init(){}
        
    init (id : String,role:String,name:String, password: String, status: String){
        self.id = id;
        self.role = role;
        self.name = name;
        self.password = password;
        self.status = status
    }
    
}

