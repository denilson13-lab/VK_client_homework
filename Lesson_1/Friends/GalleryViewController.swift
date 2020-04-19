//
//  GalleryViewController.swift
//  Lesson_1
//
//  Created by Denis on 18.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.


import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var pictureContraint: NSLayoutConstraint!
    @IBOutlet weak var pictureWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nextPictureConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextPictureWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var pictureNext: UIImageView!
    
    let pictureArray = ["scientists","authors","medics","artists","sculpture"]
    
    var currentImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picture.image = UIImage(named: pictureArray[0])
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
                //  FORWARD ANIMATION
                
            case UISwipeGestureRecognizer.Direction.left:
                
                if currentImage == pictureArray.count - 1{
                    
                    UIView.animateKeyframes(
                        withDuration: 1,
                        delay: 0,
                        options: [],
                        animations: {
                            
                            UIView.addKeyframe(
                                withRelativeStartTime: 0,
                                relativeDuration: 0.5,
                                animations: {
                                    self.nextPictureConstraint.constant += 30
                                    self.nextPictureWidthConstraint.constant -= 100
                                    self.pictureContraint.constant += 30
                                    self.pictureWidthConstraint.constant -= 100
                                    
                                    self.pictureNext.superview?.layoutIfNeeded()

                            })
                            
                            UIView.addKeyframe(
                                withRelativeStartTime: 0.5,
                                relativeDuration: 0.5,
                                animations: {
                                    self.nextPictureConstraint.constant -= 30
                                    self.nextPictureWidthConstraint.constant += 100
                                    self.pictureContraint.constant -= 30
                                    self.pictureWidthConstraint.constant += 100
                                    
                                    self.pictureNext.superview?.layoutIfNeeded()
                            })
                    })
                    
                    break
                    
                }else{
                    
                    picture.image = UIImage(named: pictureArray[currentImage])
                    pictureNext.image = UIImage(named: pictureArray[currentImage + 1])
                    
                    
                    UIView.animateKeyframes(
                        withDuration: 2,
                        delay: 0,
                        options: [],
                        animations: {
                            
                            UIView.addKeyframe(
                                withRelativeStartTime: 0,
                                relativeDuration: 0.5,
                                animations: {
                                    self.pictureContraint.constant += 30
                                    self.pictureWidthConstraint.constant -= 100
                                    self.picture.superview?.layoutIfNeeded()
                                    self.picture.alpha = 0.5
                            })
                            
                            UIView.addKeyframe(
                                withRelativeStartTime: 0,
                                relativeDuration: 0,
                                animations: {
                                    self.nextPictureConstraint.constant += 414
                                    self.pictureNext.superview?.layoutIfNeeded()
                            })
                            
                            UIView.addKeyframe(
                                withRelativeStartTime: 0.3,
                                relativeDuration: 0.5,
                                animations: {
                                    self.nextPictureConstraint.constant -= 414
                                    self.pictureNext.superview?.layoutIfNeeded()
                            })
                            
                            UIView.addKeyframe(
                                withRelativeStartTime: 1,
                                relativeDuration: 0,
                                animations: {
                                    self.pictureContraint.constant -= 30
                                    self.pictureWidthConstraint.constant += 100
                                    self.picture.alpha = 1
                                    self.picture.superview?.layoutIfNeeded()
                            })
                    },
                        completion: nil)
                    
                    currentImage += 1
                }
                
                
                
                //  BACKWARD ANIMATION
                
            case UISwipeGestureRecognizer.Direction.right:
                
                if currentImage == 0 {
                    
                    UIView.animateKeyframes(
                        withDuration: 1,
                        delay: 0,
                        options: [],
                        animations: {
                            
                            
                            UIView.addKeyframe(
                                withRelativeStartTime: 0,
                                relativeDuration: 0.5,
                                animations: {
                                    self.nextPictureConstraint.constant += 30
                                    self.nextPictureWidthConstraint.constant -= 100
                                    self.pictureContraint.constant += 30
                                    self.pictureWidthConstraint.constant -= 100
                                    
                                    self.pictureNext.superview?.layoutIfNeeded()

                            })
                            
                            UIView.addKeyframe(
                                withRelativeStartTime: 0.5,
                                relativeDuration: 0.5,
                                animations: {
                                    self.nextPictureConstraint.constant -= 30
                                    self.nextPictureWidthConstraint.constant += 100
                                    self.pictureContraint.constant -= 30
                                    self.pictureWidthConstraint.constant += 100
                                    
                                    self.pictureNext.superview?.layoutIfNeeded()
                            })
                    })
                    
                    break
                    
                }else{
                    
                    picture.image = UIImage(named: pictureArray[currentImage])
                    pictureNext.image = UIImage(named: pictureArray[currentImage - 1])
                    
                    
                    UIView.animateKeyframes(
                        withDuration: 2,
                        delay: 0,
                        options: [],
                        animations: {
                            
                            UIView.addKeyframe(
                                withRelativeStartTime: 0,
                                relativeDuration: 0.5,
                                animations: {
                                    self.pictureContraint.constant += 30
                                    self.pictureWidthConstraint.constant -= 100
                                    self.picture.superview?.layoutIfNeeded()
                                    self.picture.alpha = 0.5
                            })
                            
                            UIView.addKeyframe(
                                withRelativeStartTime: 0,
                                relativeDuration: 0,
                                animations: {
                                    self.nextPictureConstraint.constant -= 414
                                    self.pictureNext.superview?.layoutIfNeeded()
                            })
                            
                            UIView.addKeyframe(
                                withRelativeStartTime: 0.3,
                                relativeDuration: 0.5,
                                animations: {
                                    self.nextPictureConstraint.constant += 414
                                    self.pictureNext.superview?.layoutIfNeeded()
                            })
                            
                            UIView.addKeyframe(
                                withRelativeStartTime: 1,
                                relativeDuration: 0,
                                animations: {
                                    self.pictureContraint.constant -= 30
                                    self.pictureWidthConstraint.constant += 100
                                    self.picture.alpha = 1
                                    self.picture.superview?.layoutIfNeeded()
                            })
                    },
                        completion: nil)
                    
                    currentImage -= 1
                }
                
            default:
                break
            }
        }
    }
}

