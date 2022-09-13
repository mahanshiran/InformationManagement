//
//  db_mangager.swift
//  sqlite swift
//
//  Created by Mahanshiran on 2021/10/20.


import Foundation
import SQLite


class StudentDB {
    private var db: Connection!
    
    //table instance
    private var students : Table!
    //columns
    private var id: Expression<String>!
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
            db = try Connection("\(path)/my_students.sqlite3")
            
            students = Table("students")
            
            id = Expression<String>("id")
            name = Expression<String>("name")
            username = Expression<String>("username")
            password = Expression<String>("password")
            member_of = Expression<String>("member_of")

            
            if(!UserDefaults.standard.bool(forKey: "is_students_db_created")){
                try db.run(students.create { t in
                    
                    t.column(id, primaryKey: true)
                    t.column(name)
                    t.column(username)
                    t.column(password)
                    t.column(member_of)
                    //t.column(id, references: users, id)

                })
                UserDefaults.standard.setValue(true, forKey: "is_students_db_created")
            }
        }catch {
            print (error)
        }
    }
    
    public func getAll() -> [StudentModel]{
        var TheUsers : [StudentModel] = []
        //cards = cards.order(usage.desc)
        
        do{
             for card in try db.prepare(students){
                
                var UserModel : StudentModel = StudentModel()
                
                UserModel.id = card[id]
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
    
    
    public func add(item : StudentModel){
        do{
            try db.run(students.insert(id <- item.id, name <- item.name, username <- item.username, password <- item.password, member_of <- item.member_of))
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
    
    public func update(item: StudentModel){
        do{
            let theCard : Table = students.filter(id == item.id)
            try db.run(theCard.update(name <- item.name, username <- item.username, password <- item.password, member_of <- item.member_of))
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    public func delete(idValue: String){
        do{
            let card: Table = students.filter(id == idValue)
            try db.run(card.delete())

        }catch{
            print(error.localizedDescription)
        }
    }

    
}
