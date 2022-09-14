//
//  db_mangager.swift
//  sqlite swift
//
//  Created by Mahanshiran on 2021/10/20.


import Foundation
import SQLite


class ParticipantDB {
    private var db: Connection!
    
    //table instance
    private var items : Table!
    //columns
    private var id: Expression<String>!
    private var aid: Expression<String>!
    
    //constructor
    init(){
        do{
            let path : String =
                NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            //creating database connection
            db = try Connection("\(path)/my_participants.sqlite3")
            
            items = Table("participants")
            
            id = Expression<String>("id")
            aid = Expression<String>("aid")


            
            if(!UserDefaults.standard.bool(forKey: "is_participants_db_created")){
                try db.run(items.create { t in
                    
                    t.column(id, primaryKey: true)
                    t.column(aid)

                })
                UserDefaults.standard.setValue(true, forKey: "is_participants_db_created")
            }
        }catch {
            print (error)
        }
    }
    
    public func getAll() -> [ParticipantModel]{
        var TheUsers : [ParticipantModel] = []
        //cards = cards.order(usage.desc)
        
        do{
             for card in try db.prepare(items){
                
                var PublicationModel : ParticipantModel = ParticipantModel()
                
                PublicationModel.id = card[id]
                PublicationModel.aid = card[aid]
                 
                TheUsers.append(PublicationModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    
    public func add(item : ParticipantModel){
        do{
            try db.run(items.insert(id <- item.id, aid <- item.aid))
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
    
    public func update(item: ParticipantModel){
        do{
            let theCard : Table = items.filter(id == item.id)
            try db.run(theCard.update(aid <- item.aid))
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    public func delete(idValue: String){
        do{
            let card: Table = items.filter(id == idValue)
            try db.run(card.delete())

        }catch{
            print(error.localizedDescription)
        }
    }

    
}
