//
//  PublicationModel.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/14.
//

import Foundation


struct PublicationModel: Identifiable, Codable, Equatable {

    public var id : String = ""
    public var aid : String = ""
    public var uid : String = ""
    public var content : String = ""
    public var modifiable : Bool = false
    public var date: Date = Date()
    
    init(){}
        
    init (aid:String,uid:String, content: String, modifiable: Bool, date: Date){
        self.aid = aid;
        self.uid = uid;
        self.content = content;
        self.modifiable = modifiable;
        self.date = date;
    }
    
    init (id : String,aid:String,uid:String, content: String, modifiable: Bool, date: Date){
        self.id = id;
        self.aid = aid;
        self.uid = uid;
        self.content = content;
        self.modifiable = modifiable;
        self.date = date;
    }
    
}
