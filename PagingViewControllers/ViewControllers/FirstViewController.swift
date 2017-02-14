//
//  FirstViewController.swift
//  PagingViewControllers
//
//  Created by eli on 2/14/17.
//  Copyright © 2017 Examples. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var sunImageView: UIImageView!
    @IBOutlet weak var leadingSunImageViewConstraint: NSLayoutConstraint!
    var sunIsRise = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FirstViewController: ScrollableViewControllerProtocol {
    
    func screenIsMoving(point offSet: CGPoint) {
        print("First, offset: \(offSet)")
        
        if offSet.x < 150 {
            if !sunIsRise {
                startDawnAnimation()
            }
            animateSunPosition(to: offSet.x)
            sunIsRise = true
        } else {
            if sunIsRise {
                startSunsetAnimation()
            }
            animateSunPosition(to: offSet.x)
            sunIsRise = false
        }
        
    }
    
}

private extension FirstViewController {

    func startSunsetAnimation() {
        sunImageView.alpha = 1.0
        UIView.animate(withDuration: 0.5) {
            [weak self] in
            self?.sunImageView.alpha = 0.0
        }
    }
    
    func startDawnAnimation() {
        sunImageView.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            [weak self] in
            self?.sunImageView.alpha = 1.0
        }
    }
    
    func animateSunPosition(to xPosition: CGFloat) {
        leadingSunImageViewConstraint.constant = 20 + xPosition * 1.25
    }
    
}
