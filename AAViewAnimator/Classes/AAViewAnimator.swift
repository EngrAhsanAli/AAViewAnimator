//
//  AAViewAnimator.swift
//  AAViewAnimator
//
//  Created by Engr. Ahsan Ali on 16/02/2017.
//  Copyright © 2017 AA-Creations. All rights reserved.
//


/// MARK:- AAViewAnimator
//AAViewAnimator is a collection of animations and transitions for UIView designed to apply animations on every UIView with options in iOS, written in Swift.
// It allows various options for animations and parameters to make them unique!

open class AAViewAnimator {
    
    /// UIView instance
    fileprivate var view: UIView
    
    /// Time interval for animation
    fileprivate var duration: TimeInterval
    
    /// view visibility after animation
    fileprivate var viewVisibility: Bool = true
    
    /// AAViewDamping for spring animation
    fileprivate var springDamping: AAViewDamping = .none
    
    /// AAViewAnimators animators
    fileprivate var animation: AAViewAnimators
    
    fileprivate var isViewAnimating: ((_ flag: Bool)->())?
    
    /// AAViewAnimator init
    ///
    /// - Parameters:
    ///   - view: view for animation
    ///   - duration: Time Interval
    ///   - springDamping: AAViewDamping
    ///   - animator: AAViewAnimators
    public init(_ view: UIView, duration: TimeInterval, springDamping: AAViewDamping? = nil, animation: AAViewAnimators) {
        self.view = view
        self.duration = duration
        self.animation = animation
        
        if let damping = springDamping {
            self.springDamping = damping
        }

    }
    
    /// Animate with AAViewAnimators options
    ///
    /// - Parameter completion: completion
    func animate(_ completion: ((_ isAnimating: Bool)->())?) {
        
        self.isViewAnimating = completion
        
        switch animation {
        case .vibrateX, .vibrateY, .scale,
             .rotateLeft, .rotateRight, .rotateRound:
            viewAnimation()
        case .fromTop, .fromBottom, .fromLeft, .fromRight, .fromFade,
             .toTop, .toBottom, .toLeft, .toRight, .toFade:
            viewTransition()
        }
    }
    
    /// View animations
    fileprivate func viewAnimation() {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.isViewAnimating?(false)
        })
        
        switch animation {
        case .vibrateX(let rate):
            self.vibrate(rate, vibrateX: true)
        case .vibrateY(let rate):
            self.vibrate(rate, vibrateX: false)
        case .scale(let rate):
            self.scaleBounce(rate)
        case .rotateLeft:
            self.rotateHorizontal(true)
        case .rotateRight:
            self.rotateHorizontal(false)
        case .rotateRound:
            self.rotateRound()
        default:
            break
        }
        
        CATransaction.commit()
        self.isViewAnimating?(true)
    }
    
    /// View Transitions
    ///
    /// - Parameter completion: completion
    fileprivate func viewTransition() {
        
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        var translationX: CGFloat = 0
        var translationY: CGFloat = 0
        
        var alphaStart: CGFloat = 0.2
        var alphaEnd: CGFloat = 1

        if !viewVisibility {
            alphaStart = 1
            alphaEnd = 0.2
        }
        
        switch animation {
        case .fromTop, .fromBottom, .fromLeft, .fromRight, .fromFade:
            viewVisibility = true
        case .toTop, .toBottom, .toLeft, .toRight, .toFade:
            viewVisibility = false
        default:
            return
        }
        
        switch animation {
        case .fromTop, .toTop:
            translationY = -screenHeight
        case .fromBottom, .toBottom:
            translationY = screenHeight
        case .fromLeft, .toLeft:
            translationX = -screenWidth
        case .fromRight, .toRight:
            translationX = screenWidth
        case .fromFade, .toFade:
            alphaStart = viewVisibility ? 0 : 1
            alphaEnd = viewVisibility ? 1 : 0
        default:
            return
        }
        
        let transform = CGAffineTransform(translationX: translationX, y: translationY)
        let start: CGAffineTransform = viewVisibility ? transform : .identity
        let end: CGAffineTransform = viewVisibility ? .identity : transform
        
        view.transform = start
        view.alpha = alphaStart
        
        let (damping, velocity) = springDamping.values

        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [.allowUserInteraction], animations: {
            
            self.view.transform = end
            self.view.alpha = alphaEnd
            
            self.isViewAnimating?(true)
            
        }) { _ in
            self.isViewAnimating?(false)
        }
    }
    
    
    /// Vibrates the view at position
    ///
    /// - Parameters:
    ///   - rate: CGFloat
    ///   - vibrateX: flag for X-axis
    fileprivate func vibrate(_ rate: CGFloat, vibrateX: Bool) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = Float(rate/(rate/2))
        animation.autoreverses = true
        
        if vibrateX {
            animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - rate, y: view.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + rate, y: view.center.y))
        }
        else {
            animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x, y: view.center.y - rate))
            animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x, y: view.center.y + rate))
        }
        
        view.layer.add(animation, forKey: "AAViewAnimatorPosition")
    }
    
    /// Scale bounce effect
    ///
    /// - Parameter rate: Float
    fileprivate func scaleBounce(_ rate:Float) {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.duration = duration
        animation.values = [1.0,rate*1.1,1.1,0.8,1.0]
        view.layer.add(animation, forKey: "AAViewAnimatorScale")
    }
    
    /// Rotates the view horizontally
    ///
    /// - Parameter isLeft: Bool
    fileprivate func rotateHorizontal(_ fromLeft: Bool) {
        
        let direction: UIViewAnimationOptions = fromLeft ? .transitionFlipFromLeft : .transitionFlipFromRight
        
        UIView.transition(with: view, duration: duration, options: direction, animations: nil, completion: nil)
    }
    
    /// Rotates the view at 360 degree
    fileprivate func rotateRound() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0.0
        animation.toValue = CGFloat(M_PI * 2.0)
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        view.layer.add(animation, forKey: "AAViewAnimatorRotation")
    }

}



