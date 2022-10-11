//
//  db_mangager.swift
//  sqlite swift
//
//  Created by Mahanshiran on 2021/10/20.


import Foundation
import SQLite


class SocietyMemberDB {
    private var db: Connection!
    
    //table instance
    private var items : Table!
    //columns
    private var id: Expression<String>!
    private var uid: Expression<String>!
    private var sid: Expression<String>!
    private var dateJoined: Expression<Date>!
    private var isApproved: Expression<Bool>!
    
    //constructor
    init(){
        do{
            let path : String =
                NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            //creating database connection
            db = try Connection("\(path)/my_societyMembers.sqlite3")
            
            items = Table("societyMembers")
            
            id = Expression<String>("id")
            uid = Expression<String>("uid")
            sid = Expression<String>("sid")
            dateJoined = Expression<Date>("dateJoined")
            isApproved = Expression<Bool>("isApproved")


            
            if(!UserDefaults.standard.bool(forKey: "is_societyMembers_db_created")){
                try db.run(items.create { t in
                    
                    t.column(id, primaryKey: true)
                    t.column(uid)
                    t.column(sid)
                    t.column(dateJoined)
                    t.column(isApproved)


                })
                UserDefaults.standard.setValue(true, forKey: "is_societyMembers_db_created")
            }
        }catch {
            print (error)
        }
    }
    
    public func getAll() -> [SocietyMember]{
        var TheUsers : [SocietyMember] = []
        //cards = cards.order(usage.desc)
        
        do{
             for card in try db.prepare(items){
                
                var PublicationModel : SocietyMember = SocietyMember()
                
                 PublicationModel.id = card[id]
                 PublicationModel.uid = card[uid]
                 PublicationModel.sid = card[sid]
                 PublicationModel.dateJoined = card[dateJoined]
                 PublicationModel.isApproved = card[isApproved]
                 
                TheUsers.append(PublicationModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    public func getAllForUser(username: String) -> [SocietyMember]{
        var TheUsers : [SocietyMember] = []
        //cards = cards.order(usage.desc)
        
        do{
            for card in try db.prepare(items.filter(username == uid)){
                
                var PublicationModel : SocietyMember = SocietyMember()
                
                PublicationModel.id = card[id]
                PublicationModel.uid = card[uid]
                PublicationModel.sid = card[sid]
                PublicationModel.dateJoined = card[dateJoined]
                PublicationModel.isApproved = card[isApproved]
                 
                TheUsers.append(PublicationModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    
    public func getAllForSociety(societyID: String, approved: Bool) -> [SocietyMember]{
        var TheUsers : [SocietyMember] = []
        //cards = cards.order(usage.desc)
        
        do{
            for card in try db.prepare(items.filter(societyID == sid && isApproved == approved)){
                
                var PublicationModel : SocietyMember = SocietyMember()
                
                PublicationModel.id = card[id]
                PublicationModel.uid = card[uid]
                PublicationModel.sid = card[sid]
                PublicationModel.dateJoined = card[dateJoined]
                PublicationModel.isApproved = card[isApproved]
                 
                TheUsers.append(PublicationModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    public func isAlreadyJoined(username: String, societyId: String) -> Bool{
        var TheUsers : [SocietyMember] = []
        //cards = cards.order(usage.desc)
        
        do{
            for card in try db.prepare(items.filter(username == uid && sid == societyId)){
                
                var PublicationModel : SocietyMember = SocietyMember()
                
                PublicationModel.id = card[id]
                PublicationModel.uid = card[uid]
                PublicationModel.sid = card[sid]
                PublicationModel.dateJoined = card[dateJoined]
                PublicationModel.isApproved = card[isApproved]
                 
                TheUsers.append(PublicationModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        if(TheUsers.isEmpty){
            return false
        }else {
            if(TheUsers.first?.isApproved == true){
                return true
            }
        }
        return false
    }
    
    
    public func add(item : SocietyMember){
        do{
            try db.run(items.insert(id <- item.id, uid <- item.uid, sid <- item.sid, dateJoined <- item.dateJoined, isApproved <- item.isApproved))
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
    
    public func update(item: SocietyMember){
        do{
            let theCard : Table = items.filter(id == item.id)
            try db.run(theCard.update(id <- item.id,uid <- item.uid, sid <- item.sid, dateJoined <- item.dateJoined, isApproved <- item.isApproved))
        }catch{
            print(error.localizedDescription)
        }
    }
    
    public func delete(societyId: String){
        do{
            let card: Table = items.filter(sid == societyId)
            try db.run(card.delete())

        }catch{
            print(error.localizedDescription)
        }
    }
    
    public func delete(userID: String, societyId: String){
        do{
            let card: Table = items.filter(uid == userID && sid == societyId)
            try db.run(card.delete())

        }catch{
            print(error.localizedDescription)
        }
    }

    
}
