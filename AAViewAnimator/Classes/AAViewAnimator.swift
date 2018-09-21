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
    
    /// Auto repeat
    fileprivate var repeatCount: Float
    
    /// Time interval for animation
    fileprivate var duration: TimeInterval
    
    /// view visibility after animation
    fileprivate var viewVisibility: Bool = true
    
    /// AAViewDamping for spring animation
    fileprivate var springDamping: AAViewDamping
    
    /// AAViewAnimators animators
    fileprivate var animation: AAViewAnimators
    
    fileprivate var isViewAnimating: IsAnimating?
    
    /// AAViewAnimator init
    ///
    /// - Parameters:
    ///   - view: view for animation
    ///   - duration: Time Interval
    ///   - springDamping: AAViewDamping
    ///   - animator: AAViewAnimators
    public init(_ view: UIView,
                duration: TimeInterval,
                repeatCount: Float,
                springDamping: AAViewDamping?,
                animation: AAViewAnimators) {
        self.view = view
        self.duration = duration
        self.animation = animation
        self.repeatCount = repeatCount
        self.springDamping = springDamping ?? .none

    }
    
    /// Animate with AAViewAnimators options
    ///
    /// - Parameter completion: completion
    func animate(_ completion: IsAnimating?) {
        
        self.isViewAnimating = completion
        
        switch animation {
        case .vibrateX, .vibrateY, .scale,
             .zoomIn, .zoomOut,
             .rotateLeft, .rotateRight, .rotateRound:
            viewAnimation()
        case .fromTop, .fromBottom, .fromLeft, .fromRight, .fromFade,
             .toTop, .toBottom, .toLeft, .toRight, .toFade:
            viewTransition()

            break
        }
    }
    
    /// View animations
    fileprivate func viewAnimation() {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.isViewAnimating?(false, self.view)
        })
        
        switch animation {
            case .vibrateX(let rate): vibrate(rate, vibrateX: true)
            
            case .vibrateY(let rate): vibrate(rate, vibrateX: false)
            
            case .scale(let rate): scaleBounce(rate)
            
            case .rotateLeft: rotateHorizontal(true)
            
            case .rotateRight: rotateHorizontal(false)
            
            case .rotateRound: rotateRound()
            
            case .zoomIn: zoomIn()
            
            case .zoomOut:  zoomOut()
            
            default:
                break
        }
        
        CATransaction.commit()
        isViewAnimating?(true, view)
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
            self.setRepeatCount()
            self.view.transform = end
            self.view.alpha = alphaEnd
            
            self.isViewAnimating?(true, self.view)
            
        }) { _ in
            self.isViewAnimating?(false, self.view)
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
        animation.repeatCount = repeatCount
        animation.autoreverses = true
        animation.isRemovedOnCompletion = true
        
        if vibrateX {
            animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - rate, y: view.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + rate, y: view.center.y))
        }
        else {
            animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x, y: view.center.y - rate))
            animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x, y: view.center.y + rate))
        }
        
        view.addAnimation(animation, forKey: .vibrate)
        
    }
    
    /// Rotates the view horizontally
    ///
    /// - Parameter isLeft: Bool
    fileprivate func rotateHorizontal(_ fromLeft: Bool) {
        
        let direction: UIViewAnimationOptions = fromLeft ? .transitionFlipFromLeft : .transitionFlipFromRight
        
        UIView.transition(with: view, duration: duration, options: direction, animations: {
            self.setRepeatCount()
        }, completion: nil)

    }
    
    /// Scale bounce effect
    ///
    /// - Parameter rate: Float
    fileprivate func scaleBounce(_ rate:Float) {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.values = [1.0,rate*1.1,1.1,0.8,1.0]
        animation.isRemovedOnCompletion = true
        view.addAnimation(animation, forKey: .scale)
    }
    
    /// Rotates the view at 360 degree
    fileprivate func rotateRound() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0.0
        animation.toValue = CGFloat(.pi * 2.0)
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.isRemovedOnCompletion = true
        view.addAnimation(animation, forKey: .rotation)
    }

    /// Zoom in effect of view
    fileprivate func zoomIn() {
        
        self.scaledHidden()
        UIView.animate(withDuration: duration, animations: {
            self.view.transform = .identity
        }, completion: nil)

    }
    
    /// Zoom out effect of view
    fileprivate func zoomOut() {
        
        UIView.animate(withDuration: duration, animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { _ in
            self.scaledHidden()
        }

    }
    
    /// Set global animation repeat count
    fileprivate func setRepeatCount() {
        UIView.setAnimationRepeatCount(repeatCount)
    }
    
    /// Hide a view with scale transformation to zero
    fileprivate func scaledHidden() {
        view.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
}



