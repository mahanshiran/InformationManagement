//
//  UserModel.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import Foundation


struct SocietyModel: Identifiable, Codable, Equatable {

    
    public var id : String = ""
    public var admin : String = "" 
    public var name : String = ""
    public var description : String = ""
    public var approved : Bool = false
    public var adminMessage: String = ""

    
    init(){}
        
    init (admin: String, name:String, description: String, approved: Bool, adminMessage: String){
        self.admin = admin;
        self.name = name;
        self.description = description;
        self.approved = approved;
        self.adminMessage = adminMessage;
    }
    
    init (id : String,admin:String,name:String, description: String, approved: Bool, adminMessage: String){
        self.id = id;
        self.admin = admin;
        self.name = name;
        self.description = description;
        self.approved = approved;
        self.adminMessage = adminMessage
    }
    
}

