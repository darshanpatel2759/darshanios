//
//  DBHelper.swift
//  databasedemo
//
//  Created by Darshan on 19/04/24.
//

import Foundation
import  SQLite3

var db:DBhelper = DBhelper()

class DBhelper
{
    
    init() {
        
        db = opendatabase()
        createtable()
        
    }
    
    let dbpath : String = "mydb.sqlite"
    var db : OpaquePointer?
    
    func opendatabase() -> OpaquePointer?{
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) .appendingPathComponent(dbpath)
        var db : OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("successfully opened connection to database at \(dbpath)")
            return db
        }
    }
    
    func createtable(){
        
        let createtablestring = "CREATE TABLE IF NOT EXISTS person(Id INTEGER PRIMARY KEY,name TEXT,age INTEGER);"
        
        var createtablestatement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createtablestring, -1, &createtablestatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createtablestatement) == SQLITE_DONE
            {
                print("person table create")
            }
            else{
                print("person table not create")
            }
            
        }else{
            print("craete table statement could not be prepared")
        }
        sqlite3_finalize(createtablestatement)
    }
    
    func inserdata(name: String, age: Int){
        
        let insertdata = "insert into person(Id, name, age) VALUES (?,?,?)"
        var stmt : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertdata, -1, &stmt, nil) == SQLITE_OK{
            sqlite3_bind_text(stmt, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(stmt, 3, Int32(age))
            
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("insert data successfully")
            }else{
                print("could not insert data")
            }
        }else{
            print("insert statement not prepared")
        }
        sqlite3_finalize(stmt)
        
    }
    func showdata() -> [person]{
        
        var arrofperson = [person]()
        arrofperson.removeAll()
        
        let qry = "select * from person"
        var stmt : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, qry, -1, &stmt, nil) == SQLITE_OK{
            
            while(sqlite3_step(stmt) == SQLITE_ROW){
                let id = sqlite3_column_int(stmt, 0)
                let name = String(cString: sqlite3_column_text(stmt, 1))
                let age = sqlite3_column_int(stmt, 2)
                
                arrofperson.append(person(id: Int(id), name: String(name), age: Int(age)))
                
            }
            return arrofperson
        }
        return arrofperson
    }
    func delete(id : Int){
        
        let dqlqry = "delete from person where id = ?;"
        var stmt : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, dqlqry, -1, &stmt, nil) == SQLITE_OK{
            sqlite3_bind_int(stmt, 1, Int32(id))
            if(sqlite3_step(stmt) == SQLITE_DONE){
            
                print("delete row")
            }else{
                print("not delete")
            }
        }else{
            print("delete statement not prepared")
        }
        sqlite3_finalize(stmt)
    }
    func update(id: Int, name: String, age: Int){
        
        let editqry = "update person set name = '\(name)', age = '\(age)' where id = '\(id)';"
        
        var stmt : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, editqry, -1, &stmt, nil) == SQLITE_OK{
            
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("update data successfully")
            }else{
                print("update data not done")
            }
        }else{
            print("update statement not prepared")
        }
        sqlite3_finalize(stmt)
    }
    
}
