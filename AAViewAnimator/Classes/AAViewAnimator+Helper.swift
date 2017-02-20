//
//  AAViewTransition+Helper.swift
//  AAViewAnimator
//
//  Created by Engr. Ahsan Ali on 16/02/2017.
//  Copyright © 2017 AA-Creations. All rights reserved.
//


/// AAViewAnimators options for animations and transitions
///
/// - fromTop: Transition from Top (View will be visible)
/// - fromBottom: Transition from Bottom (View will be visible)
/// - fromLeft: Transition from Left (View will be visible)
/// - fromRight: Transition from Right (View will be visible)
/// - fromFade: Transition with Fade (View will be visible)
/// - toTop: Transition to Top (View will not be visible)
/// - toBottom: Transition to Bottom (View will not be visible)
/// - toLeft: Transition to Left (View will not be visible)
/// - toRight: Transition to Right (View will not be visible)
/// - toFade: Transition with Fade (View will not be visible)
/// - scale: Animation with Scale effect
/// - vibrateX: Animation with vibrate at x axis effect
/// - vibrateY: Animation with vibrate at y axis effect
/// - rotateLeft: Animation with left rotation effect
/// - rotateRight: Animation with right rotation effect
/// - rotateRound: Animation with round rotation effect
public enum AAViewAnimators {
    case fromTop, fromBottom, fromLeft, fromRight, fromFade
    case toTop, toBottom, toLeft, toRight, toFade
    case scale(rate:Float)
    case vibrateX(rate:CGFloat), vibrateY(rate:CGFloat)
    case rotateLeft, rotateRight, rotateRound
}

/// AAViewDamping for springiness effect of view
///
/// - none: no effect (default)
/// - slight: slight bounce
/// - heavy: more bounce
/// - custom: custom values for spring damping and initial velocity
public enum AAViewDamping {
    case none, slight, heavy, custom(damping: CGFloat, velocity: CGFloat)
    
    var values: (damping: CGFloat, velocity: CGFloat) {
        switch self {
        case .none: return (damping: 1.0, velocity: 1.0)
        case .slight: return (damping: 0.7, velocity: 1.5)
        case .heavy: return (damping: 0.6, velocity: 2.0)
        case .custom(let damping, let velocity): return (damping: damping, velocity: velocity)
        }
    }
}
