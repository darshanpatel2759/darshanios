//
//  person.swift
//  databasedemo
//
//  Created by Darshan on 19/04/24.
//

import Foundation

class person
{
    
    var name : String = ""
    var age : Int = 0
    var id : Int = 0
    
    init(id:Int, name:String, age:Int) {
        
        self.id = id
        self.name = name
        self.age = age
    }
}
