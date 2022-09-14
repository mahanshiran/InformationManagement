//
//  db_mangager.swift
//  sqlite swift
//
//  Created by Mahanshiran on 2021/10/20.


import Foundation
import SQLite


class RecordDB {
    private var db: Connection!
    
    //table instance
    private var items : Table!
    //columns
    private var id: Expression<String>!
    private var members: Expression<Int>!
    private var activities: Expression<Int>!
    private var publications: Expression<Int>!
    private var members_deleted: Expression<Int>!
    private var activities_deleted: Expression<Int>!
    private var engagement: Expression<Double>!
    private var date_created: Expression<Date>!
    

    //constructor
    init(){
        do{
            let path : String =
                NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            //creating database connection
            db = try Connection("\(path)/my_records.sqlite3")
            
            items = Table("records")
            
            id = Expression<String>("id")
            members = Expression<Int>("members")
            activities = Expression<Int>("activities")
            publications = Expression<Int>("publications")
            members_deleted = Expression<Int>("members_deleted")
            activities_deleted = Expression<Int>("activities_deleted")
            engagement = Expression<Double>("engagement")
            date_created = Expression<Date>("date_created")


            
            if(!UserDefaults.standard.bool(forKey: "is_records_db_created")){
                try db.run(items.create { t in
                    
                    t.column(id, primaryKey: true)
                    t.column(members)
                    t.column(activities)
                    t.column(publications)
                    t.column(members_deleted)
                    t.column(engagement)
                    t.column(date_created)


                })
                UserDefaults.standard.setValue(true, forKey: "is_records_db_created")
            }
        }catch {
            print (error)
        }
    }
    
    public func getAll() -> [RecordModel]{
        var TheUsers : [RecordModel] = []
        //cards = cards.order(usage.desc)
        
        do{
             for card in try db.prepare(items){
                
                var RecordModel : RecordModel = RecordModel()
                
                RecordModel.id = card[id]
                RecordModel.members = card[members]
                RecordModel.activities = card[activities]
                RecordModel.publications = card[publications]
                RecordModel.members_deleted = card[members_deleted]
                RecordModel.engagement = card[engagement]
                RecordModel.date_created = card[date_created]
                 
                
                TheUsers.append(RecordModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    
    public func add(item : RecordModel){
        do{
            try db.run(items.insert(id <- item.id, members <- item.members, activities <- item.activities, publications <- item.publications, members_deleted <- item.members_deleted,engagement <- item.engagement,date_created <- item.date_created))
        }catch{
            print(error.localizedDescription)
        }
    }
    
//    public func batchInsert(fileactivities: Int){
//        let theCards = Bundle.main.decode([RecordModel].self, from: fileactivities + ".json").shuffled()
//        for card in theCards{
//            addCard(card: card)
//        }
//    }
    
    public func update(item: RecordModel){
        do{
            let theCard : Table = items.filter(id == item.id)
            try db.run(theCard.update(members <- item.members, activities <- item.activities, publications <- item.publications, members_deleted <- item.members_deleted,engagement <- item.engagement,date_created <- item.date_created))
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
