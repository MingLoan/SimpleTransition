//
//  ViewController.swift
//  SimpleTransition
//
//  Created by Keith on 12/30/2015.
//  Copyright (c) 2015 Keith. All rights reserved.
//


import UIKit
import SimpleTransition

class ViewController: UIViewController {
    
    @IBOutlet weak var animationTypeSegment: UISegmentedControl!
    @IBOutlet weak var presentingViewSizeSegment: UISegmentedControl!
    @IBOutlet weak var animatedMotionSegment: UISegmentedControl!
    @IBOutlet weak var horizontalAlignmentSegment: UISegmentedControl!
    @IBOutlet weak var verticleAlignmentSegment: UISegmentedControl!
    @IBOutlet weak var transitionDirectionSegment: UISegmentedControl!
    @IBOutlet weak var sizeSegment: UISegmentedControl!
    
    @IBOutlet weak var animationTypeLabel: UILabel!
    @IBOutlet weak var presentingViewSizeLabel: UILabel!
    @IBOutlet weak var animatedMotionLabel: UILabel!
    @IBOutlet weak var horizontalAlignmentLabel: UILabel!
    @IBOutlet weak var verticleAlignmentLabel: UILabel!
    @IBOutlet weak var transitionDirectionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animatedMotionLabel.hidden = true
        animatedMotionSegment.hidden = true
        transitionDirectionLabel.hidden = true
        transitionDirectionSegment.hidden = true
    }
    
    @IBAction func animationChanged(sender: AnyObject) {
        if animationTypeSegment.selectedSegmentIndex == 0 {
            
            animatedMotionSegment.selectedSegmentIndex = 0
            
            animatedMotionLabel.hidden = true
            animatedMotionSegment.hidden = true
            transitionDirectionLabel.hidden = true
            transitionDirectionSegment.hidden = true
            
            horizontalAlignmentLabel.hidden = false
            horizontalAlignmentSegment.hidden = false
            verticleAlignmentLabel.hidden = false
            verticleAlignmentSegment.hidden = false
        }
        else {
            animatedMotionLabel.hidden = false
            animatedMotionSegment.hidden = false
            transitionDirectionLabel.hidden = false
            transitionDirectionSegment.hidden = false
            
            horizontalAlignmentLabel.hidden = true
            horizontalAlignmentSegment.hidden = true
            verticleAlignmentLabel.hidden = true
            verticleAlignmentSegment.hidden = true
        }
    }
    
    @IBAction func present(sender: AnyObject) {

        let presentedViewCtl: PresentedViewController! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PresentedViewController") as! PresentedViewController
        
        let simpleTransitionDelegate: SimpleTransition = SimpleTransition(presentingViewController: self, presentedViewController: presentedViewCtl)
        
        if animationTypeSegment.selectedSegmentIndex == 0 {
            simpleTransitionDelegate.animation = .Dissolve
        }
        else {
            switch transitionDirectionSegment.selectedSegmentIndex {
            case 0:
                simpleTransitionDelegate.animation = .LeftEdge
                break
            case 1:
                simpleTransitionDelegate.animation = .RightEdge
                break
            case 2:
                simpleTransitionDelegate.animation = .TopEdge
                break
            case 3:
                simpleTransitionDelegate.animation = .BottomEdge
                break
            default:
                break
            }
            
            if animatedMotionSegment.selectedSegmentIndex == 0 {
                simpleTransitionDelegate.animatedMotionOption = .EaseInOut
            }
            else {
                simpleTransitionDelegate.animatedMotionOption = .Spring
            }
        }
        
        if presentingViewSizeSegment.selectedSegmentIndex == 0 {
            simpleTransitionDelegate.presentingViewSizeOption = .KeepSize
        }
        else {
            simpleTransitionDelegate.presentingViewSizeOption = .Shrink
        }
        
        if sizeSegment.selectedSegmentIndex == 0 {
            simpleTransitionDelegate.presentedViewSize = CGSizeMake(SimpleTransition.flexibleDimension, SimpleTransition.flexibleDimension)
        }
        else {
            simpleTransitionDelegate.presentedViewSize = CGSizeMake(SimpleTransition.flexibleDimension, 300)
        }
        
        simpleTransitionDelegate.animationDuration = 0.6
        presentedViewCtl.simpleTransitionDelegate = simpleTransitionDelegate
        
        self.presentViewController(presentedViewCtl, animated: true, completion: nil)

    }
}