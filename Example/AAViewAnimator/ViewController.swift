//
//  ViewController.swift
//  AAViewAnimator
//
//  Created by Engr. Ahsan Ali on 16/02/2017.
//  Copyright © 2017 AA-Creations. All rights reserved.
//

import UIKit
import AAViewAnimator

class ViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateWithTransition(_ animator: AAViewAnimators) {
        animationView.aa_animate(duration: 1.2, springDamping: .slight, animation: animator) { inAnimating, animView in
            
            if inAnimating {
                print("Animating ....")
            }
            else {
                print("Animation Done 👍🏻")
            }
        }
    }
    
    func animateSender(_ sender: UIButton) {
        sender.aa_animate(duration: 0.05, animation: .vibrateX(rate: 5))
    }
    
    @IBAction func hybridAction(_ sender: UIButton) {
        animationView.aa_animate(duration: 1.2, repeatCount: 1 ,springDamping: .slight, animation: .fromTop) { inAnimating, animView in
            
            if inAnimating {
                print("Animating ....")
            }
            else {
                print("Animation Done 👍🏻")
            }
            
            guard inAnimating else {
                return
            }
            
            self.animateWithTransition(.rotateRound)
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.animationView.removeAllAnimations()
//        }
        
    }
    
    @IBAction func fromTopAction(_ sender: UIButton) {
        animateWithTransition(.fromTop)
        animateSender(sender)
    }
    
    @IBAction func fromBottomAction(_ sender: UIButton) {
        animateWithTransition(.fromBottom)
        animateSender(sender)
    }
    
    @IBAction func fromLeftAction(_ sender: UIButton) {
        animateWithTransition(.fromLeft)
        animateSender(sender)
    }
    
    @IBAction func fromRightAction(_ sender: UIButton) {
        animateWithTransition(.fromRight)
        animateSender(sender)

    }
    
    @IBAction func fadeAction(_ sender: UIButton) {
        animateWithTransition(.fromFade)
        animateSender(sender)
    }
    
    @IBAction func toBottomAction(_ sender: UIButton) {
        animateWithTransition(.toBottom)
        animateSender(sender)
    }
    
    @IBAction func toTopAction(_ sender: UIButton) {
        animateWithTransition(.toTop)
        animateSender(sender)
    }
    
    @IBAction func toLeftAction(_ sender: UIButton) {
        animateWithTransition(.toLeft)
        animateSender(sender)
    }
    
    @IBAction func toRightAction(_ sender: UIButton) {
        animateWithTransition(.toRight)
        animateSender(sender)
    }
    
    @IBAction func toFadeAction(_ sender: UIButton) {
        animateWithTransition(.toFade)
        animateSender(sender)
    }
    
    
    // Animators
    
    @IBAction func scaleAction(_ sender: UIButton) {
        animationView.aa_animate(animation: .scale(rate: 1.2))
        animateSender(sender)
    }
    
    @IBAction func vibrateXAction(_ sender: UIButton) {
        animationView.aa_animate(duration: 0.05, animation: .vibrateX(rate: 5))
        animateSender(sender)

    }
    
    @IBAction func vibrateYAction(_ sender: UIButton) {
        animationView.aa_animate(duration: 0.05, animation: .vibrateY(rate: 5))
        animateSender(sender)
    }

    @IBAction func rotateLeftAction(_ sender: UIButton) {
        animationView.aa_animate(duration: 0.5, animation: .rotateLeft)
        animateSender(sender)
    }
    
    @IBAction func rotateRightAction(_ sender: UIButton) {
        animationView.aa_animate(duration: 0.5, animation: .rotateRight)
        animateSender(sender)
    }
    
    @IBAction func rotateRoundAction(_ sender: UIButton) {
        animationView.aa_animate(duration: 0.5, animation: .rotateRound)
        animateSender(sender)
    }
}

