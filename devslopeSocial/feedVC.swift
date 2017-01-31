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

class feedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageAdd: circleView!
    @IBOutlet weak var postField: fancyField!
    var imageSelected = false

    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    var messages: [FIRDataSnapshot]! = []
    var storageRef: FIRStorageReference!
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })

    }
    
    

    
//    @IBAction func signOutTapped(_ sender: Any) {
//        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
//        print("SAM: ID removed from keychain")
//        try! FIRAuth.auth()?.signOut()
//        performSegue(withIdentifier: "goToSignIn", sender: nil)
//    }
    
    @IBAction func addImageTapped(_ sender: AnyObject) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
   
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? postCell {
            if let img = feedVC.imageCache.object(forKey: post.imageUrl as NSString) {
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                cell.configureCell(post: post)
                return cell
            }
        } else {
            return postCell()
        }
        
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageAdd.image = image
            imageSelected = true
        } else {
            print("SAM: A valid Image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

    
    
    @IBAction func postBtnTapped(_ sender: Any) {
        guard let caption = postField.text, caption != "" else {
            print("SAM: Caption must be entered")
            return
        }
        guard let img = imageAdd.image, imageSelected == true else {
            print("SAM: An image must be selected")
            return
        }
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            
            let imgUID = NSUUID().uuidString
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            //above tells firebase to make the image a jpeg. otherwise it will infer.
            DataService.ds.REF_POST_IMAGES.child(imgUID).put(imgData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print("SAM: Unable to upload image to firebase storage \(error)")
                } else {
                    print("SAM: Successfully uploaded image to firebase storage.")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                         self.postToFirebase(imgURL: url)
                    }
                   
                }
                
            }
        }
    }

    
    func postToFirebase(imgURL: String) {
        let post: Dictionary<String, Any> = [
            "caption": postField.text!,
            "imageUrl": imgURL,
            "likes": 0
        ]
        //this is selecting where we want to put it.
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        postField.text = ""
        imageSelected = false
        imageAdd.image = UIImage(named: "add-image")
        
        tableView.reloadData()
    }
    
    
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
