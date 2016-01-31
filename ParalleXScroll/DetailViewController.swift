//
//  DetailViewController.swift
//  ParalleXScroll
//
//  Created by Deepak Kadarivel on 31/01/16.
//  Copyright © 2016 upbeatios. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var image: String!
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = UIImage(named: image)
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.imageView.userInteractionEnabled = true
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("handlePan:"))
        self.imageView.addGestureRecognizer(panGestureRecognizer)
    }
    
    func handlePan(sender: UIPanGestureRecognizer){
        if(sender.state == UIGestureRecognizerState.Ended){
            self.dismissViewControllerAnimated(true , completion: nil);
        } else {
            self.dismissViewControllerAnimated(true , completion: nil);
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
