//
//  feedVC.swift
//  devslopeSocial
//
//  Created by Sam Greenhill on 1/7/17.
//  Copyright © 2017 simplyAmazingMachines. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class feedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func signOutTapped(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("SAM: ID removed from keychain")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
    
    
    
    
    
    
    

  
}
