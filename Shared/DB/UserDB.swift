//
//  db_mangager.swift
//  sqlite swift
//
//  Created by Mahanshiran on 2021/10/20.


import Foundation
import SQLite


class UserDB {
    private var db: Connection!
    
    //table instance
    private var users : Table!
    //columns
    private var id: Expression<String>!
    private var role: Expression<String>!
    private var name: Expression<String>!
    private var password: Expression<String>!
    private var status: Expression<String>!
    

    //constructor
    init(){
        do{
            let path : String =
                NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            //creating database connection
            db = try Connection("\(path)/my_users.sqlite3")
            
            users = Table("users")
            
            id = Expression<String>("id")
            role = Expression<String>("role")
            name = Expression<String>("name")
            password = Expression<String>("password")
            status = Expression<String>("status")

            
            if(!UserDefaults.standard.bool(forKey: "is_users_db_created")){
                try db.run(users.create { t in
                    
                    t.column(id, primaryKey: true)
                    t.column(role)
                    t.column(name)
                    t.column(password)
                    t.column(status)

                })
                UserDefaults.standard.setValue(true, forKey: "is_users_db_created")
            }
        }catch {
            print (error)
        }
    }
    
    public func getAll() -> [UserModel]{
        var TheUsers : [UserModel] = []
        //cards = cards.order(usage.desc)
        
        do{
             for card in try db.prepare(users){
                
                var UserModel : UserModel = UserModel()
                
                UserModel.id = card[id]
                UserModel.role = card[role]
                 UserModel.name = card[name]
                 UserModel.password = card[password]
                 UserModel.status = card[status]
                
                TheUsers.append(UserModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers
    }
    
    public func getUserWithUsername(userName: String) -> UserModel?{
        var TheUsers : [UserModel] = []
        //cards = cards.order(usage.desc)
        
        do{
            for card in try db.prepare(users.filter(id == userName)){
                
                var UserModel : UserModel = UserModel()
                
                UserModel.id = card[id]
                UserModel.role = card[role]
                UserModel.name = card[name]
                UserModel.password = card[password]
                UserModel.status = card[status]
                
                TheUsers.append(UserModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers.isEmpty ? nil : TheUsers.first
    }
    
    
    public func add(item : UserModel){
        do{
            try db.run(users.insert(id <- item.id, role <- item.role, name <- item.name, password <- item.password, status <- item.status))
        }catch{
            print(error.localizedDescription)
        }
    }
    
    public func batchInsert(fileName: String){
        let theCards = Bundle.main.decode([UserModel].self, from: fileName + ".json")
        for card in theCards{
            add(item: card)
        }
    }
    
    public func update(item: UserModel){
        do{
            let theCard : Table = users.filter(id == item.id)
            try db.run(theCard.update(id <- item.id, role <- item.role, name <- item.name, password <- item.password, status <- item.status))
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    public func delete(idValue: String){
        do{
            let card: Table = users.filter(id == idValue)
            try db.run(card.delete())

        }catch{
            print(error.localizedDescription)
        }
    }

    
}
