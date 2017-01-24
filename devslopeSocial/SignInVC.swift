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
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: fancyField!
    
    @IBOutlet weak var pwfield: fancyField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("SAM: ID found in keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
                let userData = ["provider": credential.provider]
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
                if let user = user {
                    let userData = ["provider": user.providerID]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
            }
        })
        
    }
    @IBAction func signInTapped(_ sender: AnyObject) {
        if let email = emailField.text, let pw = pwfield.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pw, completion: { (user, error) in
                if error == nil {
                    print("SAM: Email user authenticate with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                    
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pw, completion: { (user, error) in
                        if error != nil {
                            print("SAM: Unable to authenticate with firebase using email\(error)")
                        } else {
                            print("SAM: Successfully able to authenticate with Firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                            
                        }
                    })
                }
            })
        }
    }
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("SAM: data saved to KeyChain")
        performSegue(withIdentifier: "goToFeed", sender: nil)
        
    }
}

