//
//  postCell.swift
//  devslopeSocial
//
//  Created by Sam Greenhill on 1/8/17.
//  Copyright © 2017 simplyAmazingMachines. All rights reserved.
//

import UIKit

class postCell: UITableViewCell {
   
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var postImg: UIImageView!
    
    @IBOutlet weak var caption: UITextView!
    
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    
    func configureCell(post: Post) {
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
    }
    

}
