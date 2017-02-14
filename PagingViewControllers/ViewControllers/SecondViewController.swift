//
//  SecondViewController.swift
//  PagingViewControllers
//
//  Created by eli on 2/14/17.
//  Copyright © 2017 Examples. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var moonImageView: UIImageView!
    @IBOutlet weak var trailingMoonImageViewConstraint: NSLayoutConstraint!
    
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

extension SecondViewController: ScrollableViewControllerProtocol {
    
    func screenIsMoving(point offSet: CGPoint) {
        print("Second, offset: \(offSet)")
    }
    
}
