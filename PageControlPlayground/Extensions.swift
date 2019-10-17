//
//  Extensions.swift
//  PageControlPlayground
//
//  Created by Matheus Coelho Espinasso on 17/10/19.
//  Copyright © 2019 mespinasso. All rights reserved.
//

import Foundation
import UIKit

// Random number (for random color)
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

// Random color (with fixed alpha)
extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 0.3)
    }
}
