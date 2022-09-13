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

    
    init(){}
        
    init (role: String){
        self.name = role;
    }
    
    init (id : String,role:String){
        self.id = id;
        self.name = role;
    }
    
}
