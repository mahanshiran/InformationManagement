//
//  StudentModel.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import Foundation
//CREATE TABLE Students (
//
//  id INT PRIMARY KEY NOT NULL,
//  name VARCHAR(50) NOT NULL,
//  username VARCHAR(50) UNIQUE NOT NULL,
//  password VARCHAR(100) NOT NULL,
//  member_of TEXT[],
//  FOREIGN KEY (students_id) REFERENCES Users(id)
//
//);


struct StudentModel: Identifiable, Codable, Equatable  {
    public var id : String = ""
    public var name : String = "" //'super_admin', 'community_admin', 'ordinary_user'
    public var username : String = ""
    public var password : String = ""
    public var member_of : String = ""
    public var image: String = "" 
    
    init(){}
        
    init (name: String,username: String, password: String, member_of: String){
        self.name = name;
        self.username = username;
        self.password = password;
        self.member_of = member_of;
    }
    
    init (id : String,name:String, username: String, password: String, member_of: String){
        self.id = id;
        self.name = name;
        self.username = username;
        self.password = password;
        self.member_of = member_of;
    }
    
}
