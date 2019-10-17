//
//  ComplexPageControlViewController.swift
//  PageControlPlayground
//
//  Created by Matheus Coelho Espinasso on 17/10/19.
//  Copyright © 2019 mespinasso. All rights reserved.
//

import UIKit

class ComplexPageControlViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var titleView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var endNotesView: UIView!
    
    var subViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { (notification) in
            print("Orientation changed!")
            self.updatePageControlSizeSettings()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    func setupPageControl() {
        subViews = [titleView, contentView, endNotesView]
        
        // Before adding subviews, remove the existing ones
        scrollView.subviews.forEach({ $0.removeFromSuperview() })
        
        // Setting the number of pages for the PageControl
        pageControl.numberOfPages = subViews.count
        
        // Updating the ScrollView and it's sub views position and size properties
        updatePageControlSizeSettings()
        
        for index in 0 ..< subViews.count {
            // Adding the subview to the ScrollView
            scrollView.addSubview(subViews[index])
        }
        
        scrollView.delegate = self
    }
    
    func updatePageControlSizeSettings() {
        for index in 0 ..< subViews.count {
            // Setting a frame based on the ScrollView proportions
            subViews[index].frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            subViews[index].frame.size = scrollView.frame.size
        }
        
        // Adjusting the scroll view size
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(subViews.count)), height: scrollView.frame.size.height)
    }
    
    /// ScrollView
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }

}
