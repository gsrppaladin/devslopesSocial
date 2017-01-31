//
//  postCell.swift
//  devslopeSocial
//
//  Created by Sam Greenhill on 1/8/17.
//  Copyright © 2017 simplyAmazingMachines. All rights reserved.
//

import UIKit
import Firebase

let storage = FIRStorage.storage()
let storageRef = storage.reference()


class postCell: UITableViewCell {
   
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var postImg: UIImageView!
    
    @IBOutlet weak var caption: UITextView!
    
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    
    
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"

        let gsReference = storage.reference(forURL: post.imageUrl)
        
        if img != nil {
            self.postImg.image = img
        } else {
            gsReference.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("SAM: Unable to download image from firebase storage \(error)")
                } else {
                    print("SAM: Image downloaded from Firebase Storage.")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            feedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                            //what was done above was downloading images and saving them in the cache, if there is an image.
                        }
                    }
                }
                
            })
        }
    }
    
}
