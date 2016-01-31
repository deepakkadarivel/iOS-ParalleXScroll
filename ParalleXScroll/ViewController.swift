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
    
    var isPresenting: Bool!
    var transitionDuration = 0.3
    var point: CGPoint!

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
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let storyBoard = UIStoryboard(name: "Detail", bundle: nil)
        let destination = storyBoard.instantiateViewControllerWithIdentifier("DetailVC") as! DetailViewController
        destination.image = images[indexPath.row]
        
        destination.transitioningDelegate = self
        destination.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        let currentRect = self.collectionView?.layoutAttributesForItemAtIndexPath(indexPath)?.frame
        self.point = CGPointMake(currentRect!.midX, currentRect!.midY)
        
        self.presentViewController(destination, animated: true, completion: nil)
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

extension ViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return transitionDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        toViewController!.view.frame = fromViewController!.view.frame
        
        if (self.isPresenting == true) {
            toViewController?.view.alpha = 0
            toViewController?.view.transform = CGAffineTransformMakeScale(0, 0)
            
            UIView.animateWithDuration(transitionDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: [], animations: { () -> Void in
                toViewController?.view.alpha = 1
                toViewController?.view.transform = CGAffineTransformMakeScale(1, 1)
                containerView?.addSubview((toViewController?.view)!)
                }, completion: { (completed) -> Void in
                    transitionContext.completeTransition(completed)
            })
        } else {
            UIView.animateWithDuration(transitionDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: [], animations: { () -> Void in
                fromViewController?.view.alpha = 0
                fromViewController?.view.transform = CGAffineTransformMakeScale(0.001, 0.001)
                }, completion: { (completed) -> Void in
                    fromViewController?.view.removeFromSuperview()
                    transitionContext.completeTransition(completed)
            })
        }
    }
}

