//
//  IntExtension.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/1/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

extension Int {
    
    var degreesToDRadians: Double { return Double(self) * .pi / 180 }
    
    var degreesToFRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}
