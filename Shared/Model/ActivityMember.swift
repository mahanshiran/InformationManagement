//
//  ParticipantModel.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/14.
//

import Foundation


struct ActivityMember: Identifiable, Codable, Equatable {

    public var id : String = UUID().uuidString
    public var uid : String = ""
    public var aid : String = ""
    public var dateJoined: Date = Date()
    public var isApproved: Bool = false
    
    init(){}
    
    init (id: String, uid : String,aid:String, dateJoined: Date, isApproved: Bool){
        self.id = id
        self.uid = uid
        self.aid = aid
        self.dateJoined = dateJoined
        self.isApproved = isApproved
    }
    
}
