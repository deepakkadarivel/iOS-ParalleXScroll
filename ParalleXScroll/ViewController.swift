//
//  ViewController.swift
//  ParalleXScroll
//
//  Created by Deepak Kadarivel on 30/01/16.
//  Copyright © 2016 upbeatios. All rights reserved.
//

import UIKit

let parallelxCellIdentifier = "parallaxCell"

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var images = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        collectionView?.decelerationRate = UIScrollViewDecelerationRateNormal
    }

    func setup() {
        for i in 0...14 {
            images.append("\(i)@2x")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let parallelxCell = collectionView.dequeueReusableCellWithReuseIdentifier(parallelxCellIdentifier, forIndexPath: indexPath) as! parallaxCollectionViewCell
        
        parallelxCell.image = UIImage(named: images[indexPath.row])!
        
        return parallelxCell
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSizeMake(collectionView.bounds.size.width, 160)
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        guard let collectionView = self.collectionView else {return}
        guard let visibleCells = collectionView.visibleCells() as? [parallaxCollectionViewCell] else {return}
        
        for parallexCell in visibleCells {
            let yOffset = ((collectionView.contentOffset.y - parallexCell.frame.origin.y) / imageHeight) * offsetSpeed
            parallexCell.offset(CGPointMake(0.0, yOffset))
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}

