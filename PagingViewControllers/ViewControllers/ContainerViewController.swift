//
//  ContainerViewController.swift
//  PagingViewControllers
//
//  Created by eli on 2/14/17.
//  Copyright © 2017 Examples. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var canvasView: CanvasView!
    var viewControllers: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = initViewControllersFromXibs()
        layoutViewControllers(horizontally: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

fileprivate extension ContainerViewController {

    func initViewControllersFromXibs() -> [UIViewController] {
        let firstVC = FirstViewController(nibName: nil, bundle: nil)
        let secondVC = SecondViewController(nibName: nil, bundle: nil)
        return [firstVC, secondVC]
    }
    
    func initViewControllersFromStoryboard() -> [UIViewController] {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let thirdVC = mainStoryboard.instantiateViewController(withIdentifier: "ThirdViewController")
        let fourthVC = mainStoryboard.instantiateViewController(withIdentifier: "FourthViewController" )
        return [thirdVC, fourthVC]
    }
    
    func layoutViewControllers(horizontally: Bool) {
        
        var viewsDict = ["scrollView" : scrollView, "superView" : view]
        let lastIndex = viewControllers.count - 1
        let orientation1 = horizontally ? "V" : "H"
        let orientation2 = horizontally ? "H" : "V"
        
        for (index, viewController) in viewControllers.enumerated() {
            
            addChildViewController(viewController)
            let currentView: UIView = viewController.view
            currentView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(currentView)
            viewsDict["currentView"] = currentView
            
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "\(orientation1):|[currentView(==superView)]|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: viewsDict))
            
            if index == 0 {
                view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "\(orientation2):|[currentView(==superView)]",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: viewsDict))
            } else if index <= lastIndex {
                view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "\(orientation2):[lastView][currentView(==superView)]",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: viewsDict))
            }
            
            if index == lastIndex {
                view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "\(orientation2):[currentView(==superView)]|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: viewsDict))
            }
            
            viewsDict["lastView"] = currentView
            didMove(toParentViewController: viewController)
        }
        
    }
    
    func scrollIsMoving(offSet: CGPoint, currentPage: Int) {
        
        let backGroundColor = currentPage == 0 ? UIColor.blue : UIColor.black
            UIView.animate(withDuration: 0.5) {
                [weak self] in
                self?.canvasView.backgroundColor = backGroundColor
            }
        
        //Notify childViewController
        guard let currentController = childViewControllers[currentPage] as? ScrollableViewControllerProtocol else {
            return
        }
        
        currentController.screenIsMoving(point: offSet)
    }
    
}

extension ContainerViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let onPage = currentPage(on: scrollView)
        scrollIsMoving(offSet: scrollView.contentOffset, currentPage: onPage)
    }
    
    func currentPage(on scrollView: UIScrollView) -> Int {
        let pageWidth = scrollView.frame.size.width
        let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        return Int(page)
    }
    
}
