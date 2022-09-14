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
    public var name : String = "" //'super_admin', 'community_admin', 'ordinary_user'
    public var username : String = ""
    public var password : String = ""
    public var member_of : String = ""
    public var image: String = "" 
    
    init(){}
        
    init (role: String,name:String, username: String, password: String, member_of: String){
        self.role = role;
        self.name = name;
        self.username = username;
        self.password = password;
        self.member_of = member_of;
    }
    
    init (id : String,role:String,name:String, username: String, password: String, member_of: String){
        self.id = id;
        self.role = role;
        self.name = name;
        self.username = username;
        self.password = password;
        self.member_of = member_of;
    }
    
}

