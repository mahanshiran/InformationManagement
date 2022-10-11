//
//  db_mangager.swift
//  sqlite swift
//
//  Created by Mahanshiran on 2021/10/20.


import Foundation
import SQLite



//public var status : String = ""
//public var date: Date = Date()

class ActivityDB {
    private var db: Connection!
    
    //table instance
    private var items : Table!
    //columns
    private var id: Expression<String>!
    private var sid: Expression<String>!
    private var creator: Expression<String>!
    private var name: Expression<String>!
    private var description: Expression<String>!
    private var status: Expression<String>!
    private var date: Expression<Date>!
    

    //constructor
    init(){
        do{
            let path : String =
                NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            //creating database connection
            db = try Connection("\(path)/my_activities.sqlite3")
            
            items = Table("activities")
            
            id = Expression<String>("id")
            sid = Expression<String>("sid")
            creator = Expression<String>("creator")
            name = Expression<String>("name")
            description = Expression<String>("description")
            status = Expression<String>("status")
            date = Expression<Date>("date")


            
            if(!UserDefaults.standard.bool(forKey: "is_activities_db_created")){
                try db.run(items.create { t in
                    
                    t.column(id, primaryKey: true)
                    t.column(sid)
                    t.column(creator)
                    t.column(name)
                    t.column(description)
                    t.column(status)
                    t.column(date)

                })
                UserDefaults.standard.setValue(true, forKey: "is_activities_db_created")
            }
        }catch {
            print (error)
        }
    }
    
    public func getAll() -> [ActivityModel]{
        var TheUsers : [ActivityModel] = []
        //cards = cards.order(usage.desc)
        
        do{
             for card in try db.prepare(items){
                
                var ActivityModel : ActivityModel = ActivityModel()
                
                ActivityModel.id = card[id]
                ActivityModel.sid = card[sid]
                ActivityModel.creator = card[creator]
                ActivityModel.name = card[name]
                ActivityModel.description = card[description]
                ActivityModel.status = card[status]
                ActivityModel.date = card[date]
                 
                
                TheUsers.append(ActivityModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    public func getAll(sDate: Date, eDate: Date) -> [ActivityModel]{
        var TheUsers : [ActivityModel] = []
        //cards = cards.order(usage.desc)
        
        do{
            for card in try db.prepare(items.filter(date >= sDate && date <= eDate)){
                
                var ActivityModel : ActivityModel = ActivityModel()
                
                ActivityModel.id = card[id]
                ActivityModel.sid = card[sid]
                ActivityModel.creator = card[creator]
                ActivityModel.name = card[name]
                ActivityModel.description = card[description]
                ActivityModel.status = card[status]
                ActivityModel.date = card[date]
                 
                
                TheUsers.append(ActivityModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    
    public func getTotalInDay(day: Int) -> (Int, Date){
        var TheUsers : [ActivityModel] = []
        items = items.order(date.desc)
        
        do{
            for card in try db.prepare(items){
                
                var ActivityModel : ActivityModel = ActivityModel()
                
                ActivityModel.id = card[id]
                ActivityModel.date = card[date]
                 
                TheUsers.append(ActivityModel)
                
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return (TheUsers.filter { a in
            a.date.get(.day, .month, .year).day == day
        }.count, (TheUsers.filter { a in
            a.date.get(.day, .month, .year).day == day
        }.first?.date ?? Date()))
    }
    
    public func getById(aid: String) -> [ActivityModel]{
        var TheUsers : [ActivityModel] = []
        //cards = cards.order(usage.desc)
        
        do{
            for card in try db.prepare(items.filter(aid == id)){
                
                var ActivityModel : ActivityModel = ActivityModel()
                
                ActivityModel.id = card[id]
                ActivityModel.sid = card[sid]
                ActivityModel.creator = card[creator]
                ActivityModel.name = card[name]
                ActivityModel.description = card[description]
                ActivityModel.status = card[status]
                ActivityModel.date = card[date]
                 
                
                TheUsers.append(ActivityModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    
    public func getForSociety(societyId: String) -> [ActivityModel]{
        var TheUsers : [ActivityModel] = []
        //cards = cards.order(usage.desc)
        
        do{
            for card in try db.prepare(items.filter(societyId == sid)){
                
                var ActivityModel : ActivityModel = ActivityModel()
                
                ActivityModel.id = card[id]
                ActivityModel.sid = card[sid]
                ActivityModel.creator = card[creator]
                ActivityModel.name = card[name]
                ActivityModel.description = card[description]
                ActivityModel.status = card[status]
                ActivityModel.date = card[date]
                 
                
                TheUsers.append(ActivityModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    
    public func add(item : ActivityModel){
        do{
            try db.run(items.insert(id <- item.id, sid <- item.sid, creator <- item.creator, name <- item.name, description <- item.description, status <- item.status,date <- item.date))
        }catch{
            print(error.localizedDescription)
        }
    }
    
//    public func batchInsert(filecreator: String){
//        let theCards = Bundle.main.decode([ActivityModel].self, from: filecreator + ".json").shuffled()
//        for card in theCards{
//            addCard(card: card)
//        }
//    }

    
    public func update(item: ActivityModel){
        do{
            let theCard : Table = items.filter(id == item.id)
            try db.run(theCard.update(id <- item.id,sid <- item.sid, creator <- item.creator, name <- item.name, description <- item.description,status <- item.status,date <- item.date))
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
