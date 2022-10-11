//
//  db_mangager.swift
//  sqlite swift
//
//  Created by Mahanshiran on 2021/10/20.


import Foundation
import SQLite


class SocietyDB {
    private var db: Connection!
    
    //table instance
    private var items : Table!
    //columns
    private var id: Expression<String>!
    private var admin: Expression<String>!
    private var name: Expression<String>!
    private var description: Expression<String>!
    private var approved: Expression<Bool>!
    private var adminMessage: Expression<String>!
    
    

    //constructor
    init(){
        do{
            let path : String =
                NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            //creating database connection
            db = try Connection("\(path)/my_society.sqlite3")
            
            items = Table("society")
            id = Expression<String>("id")
            admin = Expression<String>("admin")
            name = Expression<String>("name")
            description = Expression<String>("description")
            approved = Expression<Bool>("approved")
            adminMessage = Expression<String>("adminMessage")
            

            
            if(!UserDefaults.standard.bool(forKey: "is_society_db_created")){
                try db.run(items.create { t in
                    
                    t.column(id, primaryKey: true)
                    t.column(admin)
                    t.column(name)
                    t.column(description)
                    t.column(approved)
                    t.column(adminMessage)

                })
                UserDefaults.standard.setValue(true, forKey: "is_society_db_created")
            }
        }catch {
            print (error)
        }
    }
    
    public func getAll() -> [SocietyModel]{
        var TheUsers : [SocietyModel] = []
        //cards = cards.order(usage.desc)
        
        do{
             for card in try db.prepare(items){
                
                var SocietyModel : SocietyModel = SocietyModel()
                
                SocietyModel.id = card[id]
                SocietyModel.admin = card[admin]
                SocietyModel.name = card[name]
                SocietyModel.description = card[description]
                SocietyModel.approved = card[approved]
                SocietyModel.adminMessage = card[adminMessage]
                 
                
                TheUsers.append(SocietyModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    public func getForAdmin(user: String) -> [SocietyModel]{
        var TheUsers : [SocietyModel] = []
        //cards = cards.order(usage.desc)
        
        do{
            for card in try db.prepare(items.filter(user == admin)){
                
                var SocietyModel : SocietyModel = SocietyModel()
                
                SocietyModel.id = card[id]
                SocietyModel.admin = card[admin]
                SocietyModel.name = card[name]
                SocietyModel.description = card[description]
                SocietyModel.approved = card[approved]
                SocietyModel.adminMessage = card[adminMessage]
                
                TheUsers.append(SocietyModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    
    public func add(item : SocietyModel){
        do{
            try db.run(items.insert(id <- item.id, admin <- item.admin, name <- item.name, description <- item.description, approved <- item.approved, adminMessage <- item.adminMessage))
        }catch{
            print(error.localizedDescription)
        }
    }
    
//    public func batchInsert(fileName: String){
//        let theCards = Bundle.main.decode([SocietyModel].self, from: fileName + ".json").shuffled()
//        for card in theCards{
//            addCard(card: card)
//        }
//    }
    
    public func update(item: SocietyModel){
        do{
            let theCard : Table = items.filter(id == item.id)
            try db.run(theCard.update(id <- item.id, admin <- item.admin, name <- item.name, description <- item.description, approved <- item.approved, adminMessage <- item.adminMessage))
        }catch{
            print(error.localizedDescription)
        }
    }
    
    public func approve(item: SocietyModel){
        do{
            let theCard : Table = items.filter(id == item.id)
            try db.run(theCard.update(id <- item.id,admin <- item.admin, name <- item.name, description <- item.description, approved <- true, adminMessage <- ""))
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
