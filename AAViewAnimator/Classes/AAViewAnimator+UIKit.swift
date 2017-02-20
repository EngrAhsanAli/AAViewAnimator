//
//  AAViewAnimator+UIKit.swift
//  AAViewAnimator
//
//  Created by Engr. Ahsan Ali on 16/02/2017.
//  Copyright © 2017 AA-Creations. All rights reserved.
//

// MARK: - UIView+AAViewAnimator
extension UIView {
    
    /// UIView Animations
    ///
    /// - Parameters:
    ///   - duration: Time interval
    ///   - springDamping: AAViewDamping damping effect
    ///   - animator: AAViewAnimators options
    ///   - completion: animation completion closure
    open func aa_animate(duration: TimeInterval = 0.5, springDamping: AAViewDamping = .none,animation: AAViewAnimators, completion: ((_ isAnimating: Bool)->())? = nil) {
        let animator = AAViewAnimator(self, duration: duration, animation: animation)
        animator.animate(completion)
    }

}

