//
//  db_mangager.swift
//  sqlite swift
//
//  Created by Mahanshiran on 2021/10/20.


import Foundation
import SQLite


class PublicationDB {
    private var db: Connection!
    
    //table instance
    private var items : Table!
    //columns
    private var id: Expression<String>!
    private var aid: Expression<String>!
    private var uid: Expression<String>!
    private var content: Expression<String>!
    private var modifiable: Expression<Bool>!
    private var date: Expression<Date>!
    

    //constructor
    init(){
        do{
            let path : String =
                NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            //creating database connection
            db = try Connection("\(path)/my_publications.sqlite3")
            
            items = Table("publications")
            
            id = Expression<String>("id")
            aid = Expression<String>("aid")
            uid = Expression<String>("uid")
            content = Expression<String>("content")
            modifiable = Expression<Bool>("modifiable")
            date = Expression<Date>("date")


            
            if(!UserDefaults.standard.bool(forKey: "is_publications_db_created")){
                try db.run(items.create { t in
                    
                    t.column(id, primaryKey: true)
                    t.column(aid)
                    t.column(uid)
                    t.column(content)
                    t.column(modifiable)
                    t.column(date)

                })
                UserDefaults.standard.setValue(true, forKey: "is_publications_db_created")
            }
        }catch {
            print (error)
        }
    }
    
    public func getAll() -> [PublicationModel]{
        var TheUsers : [PublicationModel] = []
        //cards = cards.order(usage.desc)
        
        do{
             for card in try db.prepare(items){
                
                var PublicationModel : PublicationModel = PublicationModel()
                
                PublicationModel.id = card[id]
                PublicationModel.aid = card[aid]
                PublicationModel.uid = card[uid]
                PublicationModel.content = card[content]
                PublicationModel.modifiable = card[modifiable]
                PublicationModel.date = card[date]
                 
                
                TheUsers.append(PublicationModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    
    public func add(item : PublicationModel){
        do{
            try db.run(items.insert(id <- item.id, aid <- item.aid, uid <- item.uid, content <- item.content, modifiable <- item.modifiable,date <- item.date))
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
    
    public func update(item: PublicationModel){
        do{
            let theCard : Table = items.filter(id == item.id)
            try db.run(theCard.update(aid <- item.aid, uid <- item.uid, content <- item.content, modifiable <- item.modifiable,date <- item.date))
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
