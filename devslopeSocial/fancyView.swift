//
//  fancyView.swift
//  devslopeSocial
//
//  Created by Sam Greenhill on 1/3/17.
//  Copyright © 2017 simplyAmazingMachines. All rights reserved.
//

import UIKit

class fancyView: UIView {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.0
        layer.shadowRadius = 5.0 //how far it blurs out
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0) //the bounds of the view, how far it will go.
        layer.cornerRadius = 2.0
    
    
    
    }


}
