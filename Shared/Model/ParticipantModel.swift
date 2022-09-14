//
//  ParticipantModel.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/14.
//

import Foundation


struct ParticipantModel: Identifiable, Codable, Equatable {

    public var id : String = ""
    public var aid : String = ""
    
    init(){}
        
    init (aid:String){
        self.aid = aid;
    }
    
    init (id : String,aid:String){
        self.id = id;
        self.aid = aid;
    }
    
}
