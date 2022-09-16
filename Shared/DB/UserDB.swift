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
    private var username: Expression<String>!
    private var password: Expression<String>!
    private var member_of: Expression<String>!
    

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
            username = Expression<String>("username")
            password = Expression<String>("password")
            member_of = Expression<String>("member_of")

            
            if(!UserDefaults.standard.bool(forKey: "is_users_db_created")){
                try db.run(users.create { t in
                    
                    t.column(id, primaryKey: true)
                    t.column(role)
                    t.column(name)
                    t.column(username)
                    t.column(password)
                    t.column(member_of)

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
                 UserModel.username = card[username]
                 UserModel.password = card[password]
                 UserModel.member_of = card[member_of]
                
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
            for card in try db.prepare(users.filter(username == userName)){
                
                var UserModel : UserModel = UserModel()
                
                UserModel.id = card[id]
                UserModel.role = card[role]
                UserModel.name = card[name]
                UserModel.username = card[username]
                UserModel.password = card[password]
                UserModel.member_of = card[member_of]
                
                TheUsers.append(UserModel)
                
            }
        }catch{
            print(error.localizedDescription)
        }
        return TheUsers.isEmpty ? nil : TheUsers.first
    }
    
    
    public func add(item : UserModel){
        do{
            try db.run(users.insert(id <- item.id, role <- item.role, name <- item.name, username <- item.username, password <- item.password, member_of <- item.member_of))
        }catch{
            print(error.localizedDescription)
        }
    }
    
//    public func batchInsert(fileName: String){
//        let theCards = Bundle.main.decode([UserModel].self, from: fileName + ".json").shuffled()
//        for card in theCards{
//            addCard(card: card)
//        }
//    }
    
    public func update(item: UserModel){
        do{
            let theCard : Table = users.filter(id == item.id)
            try db.run(theCard.update(role <- item.role, name <- item.name, username <- item.username, password <- item.password, member_of <- item.member_of))
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
