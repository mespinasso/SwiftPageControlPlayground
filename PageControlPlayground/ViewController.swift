//
//  ViewController.swift
//  PageControlPlayground
//
//  Created by Matheus Coelho Espinasso on 16/10/19.
//  Copyright © 2019 mespinasso. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Initial page contents
    var strings = ["This is the first page", "This is the second", "And here is the third"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Watching for orientation change to redraw the page controll
        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { (notification) in
            self.strings.append("Orientation generated string: \(notification.description)")
            self.setupPageControl()
        }
        
        setupPageControl()
    }
    
    func setupPageControl() {
        // Setting the number of pages for the PageControl
        pageControl.numberOfPages = strings.count
        
        // Before adding subviews, remove the existing ones
        scrollView.subviews.forEach({ $0.removeFromSuperview() })
        
        for index in 0 ..< strings.count {
            // Setting a frame based on the ScrollView proportions
            var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            // Creating a label using the frame (could be replaced by a View containing other subviews)
            let label = UILabel(frame: frame)
            label.text = strings[index]
            label.backgroundColor = .random()
            
            // Adding the newly created table to the ScrollView
            self.scrollView.addSubview(label)
        }
        
        // Adjusting the scroll view size
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(strings.count)) , height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    
    /// ScrollView
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }

}
