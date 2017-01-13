//
//  circleView.swift
//  devslopeSocial
//
//  Created by Sam Greenhill on 1/8/17.
//  Copyright © 2017 simplyAmazingMachines. All rights reserved.
//

import UIKit

class circleView: UIImageView {
    
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
//        layer.shadowOpacity = 0.8
//        layer.shadowRadius = 5.0 //how far it blurs out
//        layer.shadowOffset = CGSize(width: 1.0, height: 1.0) //the bounds of the view, how far it will go.
//    }
//
    override func layoutSubviews() {
//        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        layer.cornerRadius = self.frame.width / 2
//        clipsToBounds = true
//    }
//    
//    
}
