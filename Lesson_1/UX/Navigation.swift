//
//  Navigation.swift
//  Lesson_1
//
//  Created by Denis on 25.04.2020.
//  Copyright © 2020 Denis Skokov. All rights reserved.
//

import UIKit

class Navigation: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self 
    }
    
    let interactiveTransition = InteractiveTransition()
}

extension Navigation: UINavigationControllerDelegate {
    
    private func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerAnimatedTransitioning? {
            
            return interactiveTransition.hasStarted ? (interactiveTransition as! UIViewControllerAnimatedTransitioning) : nil
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            self.interactiveTransition.viewController = toVC
            return PushAnimator()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return PopAnimator()
        }
        return nil
    }
}

final class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration = 0.6
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        
        let zeroMomentTranslation = CGAffineTransform(translationX: 300, y: 650)
        let zeroMomentRotation = CGAffineTransform (rotationAngle: -.pi / 2)
        destination.view.transform = zeroMomentTranslation.concatenating(zeroMomentRotation)
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced,
                                animations: {
                                    
                                    UIView.addKeyframe(
                                        withRelativeStartTime: 0,
                                        relativeDuration: 0.75,
                                        animations: {
                                            let translation = CGAffineTransform(translationX: -150, y: 600)
                                            let rotation = CGAffineTransform (rotationAngle: .pi / 2)
                                            source.view.transform = translation.concatenating(rotation)
                                    })
                                    
                                    UIView.addKeyframe(
                                        withRelativeStartTime: 0.6,
                                        relativeDuration: 0.4,
                                        animations: {
                                            destination.view.transform = .identity
                                    })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}

final class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration = 0.6
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        destination.view.frame = source.view.frame
        
        let zeroMomentTranslation = CGAffineTransform(translationX: -150, y: 600)
        let zeroMomentRotation = CGAffineTransform (rotationAngle: .pi / 2)
        destination.view.transform = zeroMomentTranslation.concatenating(zeroMomentRotation)

        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced,
                                animations: {
                                    
                                    UIView.addKeyframe(
                                        withRelativeStartTime: 0,
                                        relativeDuration: 0.75,
                                        animations: {
                                            let translation = CGAffineTransform(translationX: 300, y: 650)
                                            let rotation = CGAffineTransform (rotationAngle: -.pi / 2)
                                            source.view.transform = translation.concatenating(rotation)
                                    })
                                    
                                    UIView.addKeyframe(
                                        withRelativeStartTime: 0.6,
                                        relativeDuration: 0.4,
                                        animations: {
                                            destination.view.transform = .identity
                                    })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
