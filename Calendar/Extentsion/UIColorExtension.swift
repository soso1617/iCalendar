//
//  UIColorExtension.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/30/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var icGreen: UIColor {
        
        return colorWithHex(0x19ab70)
    }
    
    class var icBlue: UIColor {
        
        return colorWithHex(0x74d1f6)
    }
    
    class var icYellow: UIColor {
        
        return colorWithHex(0xecb438)
    }
    
    class var icChocolate: UIColor {
        
        return colorWithHex(0x4d394b)
    }
    
    class var icLightGray: UIColor {
        
        return colorWithHex(0xd6d6d6)
    }
    
    class var icGray: UIColor {
        
        return colorWithHex(0x8e8e8e)
    }
    
    class var icRed: UIColor {
        
        return colorWithHex(0xe94f5f)
    }
    
    class var icOrange: UIColor {
        
        return colorWithHex(0xff4605)
    }

    class var icBlackishGreen: UIColor {
        
        return colorWithHex(0x137ea2)
    }
    
    class var icBackground: UIColor {
        
        return colorWithHex(0xf2f2f2)
    }
    
    class var icPinkish: UIColor {
        
        return colorWithHex(0xe3b3a2)
    }
    
    class var icGrayishBlue: UIColor {
        
        return colorWithHex(0x8fbccf)
    }
    
    class var icTintColor: UIColor {
        
        return icWhite
    }
    
    class var icDisableColor: UIColor {
        
        return UIColor.lightGray
    }
    
    class var dayColor: UIColor {
        
        return UIColor.icGreen
    }
    
    class var todayColor: UIColor {
        
        return UIColor.icPinkish
    }

    class var icWhite: UIColor {
        
        return UIColor.white
    }
    
    class var icBlack: UIColor {
        
        return UIColor.black
    }
    
    class var icSeparator: UIColor {
        
        return UIColor.icLightGray
    }
    
    class var icTextColor: UIColor {
    
        return colorWithHex(0x475061)
    }
    
    class func colorWithHex(_ hexValue: Int) -> UIColor {
        
        return UIColor.init(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((hexValue & 0x00FF00) >>  8) / 255.0,
                            blue: CGFloat((hexValue & 0x0000FF) >>  0) / 255.0,
                            alpha: 1.0)
    }
}
