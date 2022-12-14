//
//  ActivityModel.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/14.
//


import Foundation

struct ActivityModel: Identifiable, Codable, Equatable {

    public var id : String = ""
    public var sid : String = ""
    public var creator : String = ""
    public var name : String = ""
    public var description : String = ""
    public var status : String = ""
    public var date: Date = Date()
    
    init(){}
        
    init (sid:String,creator:String, name: String, description: String, status: String, date: Date){
        self.sid = sid;
        self.creator = creator;
        self.name = name;
        self.description = description;
        self.status = status;
        self.date = date;
    }
    
    init (id : String,sid:String,creator:String, name: String, description: String, status: String, date: Date){
        self.id = id;
        self.sid = sid;
        self.creator = creator;
        self.name = name;
        self.description = description;
        self.status = status;
        self.date = date;
    }
    
}
