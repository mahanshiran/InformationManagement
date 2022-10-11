//
//  db_mangager.swift
//  sqlite swift
//
//  Created by Mahanshiran on 2021/10/20.


import Foundation
import SQLite


class ActivityMemberDB {
    private var db: Connection!
    
    //table instance
    private var items : Table!
    //columns
    private var id: Expression<String>!
    private var uid: Expression<String>!
    private var aid: Expression<String>!
    private var dateJoined: Expression<Date>!
    private var isApproved: Expression<Bool>!
    
    
    //constructor
    init(){
        do{
            let path : String =
                NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            //creating database connection
            db = try Connection("\(path)/my_activityMembers.sqlite3")
            
            items = Table("activityMembers")
            
            id = Expression<String>("id")
            uid = Expression<String>("uid")
            aid = Expression<String>("aid")
            dateJoined = Expression<Date>("dateJoined")
            isApproved = Expression<Bool>("isApproved")


            
            if(!UserDefaults.standard.bool(forKey: "is_activityMembers_db_created")){
                try db.run(items.create { t in
                    
                    t.column(id, primaryKey: true)
                    t.column(uid)
                    t.column(aid)
                    t.column(dateJoined)
                    t.column(isApproved)

                })
                UserDefaults.standard.setValue(true, forKey: "is_activityMembers_db_created")
            }
        }catch {
            print (error)
        }
    }
    
    public func getAll() -> [ActivityMember]{
        var TheUsers : [ActivityMember] = []
        //cards = cards.order(usage.desc)
        
        do{
             for card in try db.prepare(items){
                
                var PublicationModel : ActivityMember = ActivityMember()
                
                PublicationModel.id = card[id]
                PublicationModel.uid = card[uid]
                PublicationModel.aid = card[aid]
                PublicationModel.dateJoined = card[dateJoined]
                PublicationModel.isApproved = card[isApproved]
                 
                 
                TheUsers.append(PublicationModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    public func getAllForUser(username: String) -> [ActivityMember]{
        var TheUsers : [ActivityMember] = []
        items = items.order(dateJoined.desc)
        
        do{
            for card in try db.prepare(items.filter(username == uid)){
                
                var PublicationModel : ActivityMember = ActivityMember()
                
                PublicationModel.id = card[id]
                PublicationModel.uid = card[uid]
                PublicationModel.aid = card[aid]
                PublicationModel.dateJoined = card[dateJoined]
                PublicationModel.isApproved = card[isApproved]
                 
                TheUsers.append(PublicationModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    
    public func getAllForActivity(activityID: String) -> [ActivityMember]{
        var TheUsers : [ActivityMember] = []
        //cards = cards.order(usage.desc)
        
        do{
            for card in try db.prepare(items.filter(activityID == aid)){
                
                var PublicationModel : ActivityMember = ActivityMember()
                
                PublicationModel.id = card[id]
                PublicationModel.uid = card[uid]
                PublicationModel.aid = card[aid]
                PublicationModel.dateJoined = card[dateJoined]
                PublicationModel.isApproved = card[isApproved]
                 
                TheUsers.append(PublicationModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    public func isAlreadyJoined(username: String, activityId: String) -> Bool{
        var TheUsers : [ActivityMember] = []
        //cards = cards.order(usage.desc)
        
        do{
            for card in try db.prepare(items.filter(username == uid && aid == activityId)){
                
                var PublicationModel : ActivityMember = ActivityMember()
                
                PublicationModel.id = card[id]
                PublicationModel.uid = card[uid]
                PublicationModel.aid = card[aid]
                PublicationModel.dateJoined = card[dateJoined]
                PublicationModel.isApproved = card[isApproved]
                 
                TheUsers.append(PublicationModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers.isEmpty ? false : true
    }
    
    
    public func add(item : ActivityMember){
        do{
            try db.run(items.insert(id <- item.id, uid <- item.uid, aid <- item.aid, dateJoined <- item.dateJoined, isApproved <- item.isApproved))
        }catch{
            print(error.localizedDescription)
        }
    }
    
//    public func batchInsert(fileuid: String){
//        let theCards = Bundle.main.decode([PublicationModel].self, from: fileuid + ".json").shuffled()
//        for card in theCards{
//            addCard(card: card)
//        }
//    }
    
    public func update(item: ActivityMember){
        do{
            let theCard : Table = items.filter(id == item.id)
            try db.run(theCard.update(id <- item.id,uid <- item.uid, aid <- item.aid, dateJoined <- item.dateJoined, isApproved <- item.isApproved))
        }catch{
            print(error.localizedDescription)
        }
    }
    
    public func delete(activity: String){
        do{
            let card: Table = items.filter(aid == activity)
            try db.run(card.delete())

        }catch{
            print(error.localizedDescription)
        }
    }
    
    public func delete(userID: String, activity: String){
        do{
            let card: Table = items.filter(uid == userID && aid == activity)
            try db.run(card.delete())

        }catch{
            print(error.localizedDescription)
        }
    }

    
}
