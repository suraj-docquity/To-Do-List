//
//  ContactModel.swift
//  To Do List
//
//  Created by Suraj Jaiswal on 09/02/23.
//

import RealmSwift
import Foundation

class Contact : Object {
    @Persisted var firstName : String
    @Persisted var lastName  : String
    
    convenience init(firstName : String, lastName : String){
        self.init()
        self.firstName = firstName
        self.lastName = lastName
    }
}
