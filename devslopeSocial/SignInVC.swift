//
//  SignInVC.swift
//  devslopeSocial
//
//  Created by Sam Greenhill on 1/1/17.
//  Copyright © 2017 simplyAmazingMachines. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookLogin
import FacebookCore

class SignInVC: UIViewController {
    

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
           }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("SAM: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("SAM: User cancelled Facebook authentication")
            } else {
                print("SAM: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("SAM: Unable to authenticate with firebase - \(error)")
            } else {
                print("SAM: Succesfully authenticated with firebase")
                
            }
        })
        
    }
    
    
    
    
    
    
    


    

}

