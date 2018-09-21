//
//  AAViewAnimator+UIKit.swift
//  AAViewAnimator
//
//  Created by Engr. Ahsan Ali on 16/02/2017.
//  Copyright © 2017 AA-Creations. All rights reserved.
//

public typealias IsAnimating = ((Bool, UIView) -> ())

// MARK: - UIView+AAViewAnimator
extension UIView {
    
    /// UIView Animations
    ///
    /// - Parameters:
    ///   - duration: Time interval
    ///   - repeatCount: Animation Repeatation
    ///   - springDamping: AAViewDamping damping effect
    ///   - animator: AAViewAnimators options
    ///   - completion: animation completion closure
    open func aa_animate(duration: TimeInterval = 0.5,
                         repeatCount: Float = 1,
                         springDamping: AAViewDamping = .none,
                         animation: AAViewAnimators,
                         completion: IsAnimating? = nil) {
        
        AAViewAnimator(self,
                       duration: duration,
                       repeatCount: repeatCount,
                       springDamping: springDamping,
                       animation: animation)
            .animate(completion)
        
    }
    
    func addAnimation(_ anim: CAAnimation, forKey: AAViewAnimationKey) {
        layer.add(anim, forKey: forKey.rawValue)
    }
    
    open func removeAnimation(_ forKey: AAViewAnimationKey) {
        layer.removeAnimation(forKey: forKey.rawValue)
    }
    
    open func removeAllAnimations() {
        layer.removeAllAnimations()
    }
}

