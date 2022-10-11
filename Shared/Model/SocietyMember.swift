//
//  ParticipantModel.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/14.
//

import Foundation


struct SocietyMember: Identifiable, Codable, Equatable {

    public var id : String = UUID().uuidString
    public var uid : String = ""
    public var sid : String = ""
    public var dateJoined: Date = Date()
    public var isApproved: Bool = false
    
    init(){}
    
    init (uid : String,sid:String, dateJoined: Date, isApproved: Bool){
        self.uid = uid;
        self.sid = sid;
        self.dateJoined = dateJoined;
        self.isApproved = isApproved
    }
    
    init (id: String, uid : String,sid:String, dateJoined: Date, isApproved: Bool){
        self.id = id
        self.uid = uid;
        self.sid = sid;
        self.dateJoined = dateJoined;
        self.isApproved = isApproved
    }
    
}
