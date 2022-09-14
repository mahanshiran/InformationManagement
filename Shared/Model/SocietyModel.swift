//
//  UserModel.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import Foundation


struct SocietyModel: Identifiable, Codable, Equatable {

    
    public var id : String = ""
    public var admin : String = "" //'super_admin', 'community_admin', 'ordinary_user'
    public var name : String = "" //'super_admin', 'community_admin', 'ordinary_user'
    public var description : String = ""
    public var approved : Bool = false

    
    init(){}
        
    init (admin: String, name:String, description: String, approved: Bool){
        self.admin = admin;
        self.name = name;
        self.description = description;
        self.approved = approved;
    }
    
    init (id : String,admin:String,name:String, description: String, approved: Bool){
        self.id = id;
        self.admin = admin;
        self.name = name;
        self.description = description;
        self.approved = approved;
    }
    
}

