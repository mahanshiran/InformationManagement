//
//  RecordModel.swift
//  InformationManagement (iOS)
//
//  Created by mahan on 2022/9/13.
//

import Foundation



struct RecordModel: Identifiable, Codable, Equatable {

    public var id : String = ""
    public var members : Int = 0
    public var activities : Int = 0
    public var publications : Int = 0
    public var members_deleted : Int = 0
    public var activities_deleted : Int = 0
    public var engagement: Double = 0
    public var date_created: Date = Date()
    
    init(){}
        
    init (members: Int,activities:Int, publications: Int, members_deleted: Int, activities_deleted: Int, engagement: Double, date_created: Date){
        self.members = members;
        self.activities = activities;
        self.publications = publications;
        self.members_deleted = members_deleted;
        self.activities_deleted = activities_deleted;
        self.engagement = engagement;
    }
    
    init (id : String,members:Int,activities:Int, publications: Int, members_deleted: Int, activities_deleted: Int, engagement: Double, date_created: Date){
        self.id = id;
        self.members = members;
        self.activities = activities;
        self.publications = publications;
        self.members_deleted = members_deleted;
        self.activities_deleted = activities_deleted;
        self.engagement = engagement;
        self.date_created = date_created;
    }
    
}
