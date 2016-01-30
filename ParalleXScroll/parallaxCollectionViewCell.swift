//
//  parallaxCollectionViewCell.swift
//  ParalleXScroll
//
//  Created by Deepak Kadarivel on 30/01/16.
//  Copyright © 2016 upbeatios. All rights reserved.
//

import UIKit

var imageHeight: CGFloat = 200.0
var offsetSpeed: CGFloat = 25.0

class parallaxCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
        }
    }
    
    func offset(offset: CGPoint) {
        imageView.frame = CGRectOffset(self.imageView.bounds, offset.x, offset.y)
    }
    
}
