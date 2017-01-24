//
//  roundBtn.swift
//  devslopeSocial
//
//  Created by Sam Greenhill on 1/3/17.
//  Copyright © 2017 simplyAmazingMachines. All rights reserved.
//

import UIKit

class roundBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0 //how far it blurs out
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0) //the bounds of the view, how far it will go.
        imageView?.contentMode = .scaleAspectFit
        //layer.cornerRadius = 5.0 --> this would round out a corner. 
        
    }
    //we want a perfectly round button
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2
    }
    

}































