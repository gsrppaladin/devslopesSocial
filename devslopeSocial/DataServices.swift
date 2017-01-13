//
//  DataServices.swift
//  devslopeSocial
//
//  Created by Sam Greenhill on 1/11/17.
//  Copyright © 2017 simplyAmazingMachines. All rights reserved.
//

import Foundation
import Firebase

//this makes it global
let DB_BASE = FIRDatabase.database().reference()
//this will contain the url or the base of our database in firebase


class DataService {
    
    //this makes it a singleton
    
    static let ds = DataService() // this creates a single instance of this.
    
    private var _REF_BASE = DB_BASE
    
    private var _REF_POSTS = DB_BASE.child("posts")//whatever is the tag is what goes here. 
    
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        
        REF_USERS.child(uid).updateChildValues(userData)
        
        
    }
    
    
    
    
    
}
