//
//  UIFontExtension.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/30/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

extension UIFont {
    
    class private func fontForSize(size: CGFloat) -> UIFont {
        
        return UIFont.init(name: "HelveticaNeue", size: size)!
    }
    
    class private func emphasisFontForSize(size: CGFloat) -> UIFont {
        
        return UIFont.init(name: "HelveticaNeue-Medium", size: size)!
    }
    
    class private func specialEmphasisFontForSize(size: CGFloat) -> UIFont {
        
        return UIFont.init(name: "Georgia-BoldItalic", size: size)!
    }
    
    //
    //  title
    //
    class var icFont1: UIFont {
        
        return UIFont.emphasisFontForSize(size: SystemConfiguration.isiPad() ? 20.0 : 18.0)
    }
    
    //
    //  sub-title
    //
    class var icFont2: UIFont {
        
        return UIFont.fontForSize(size: SystemConfiguration.isiPad() ? 16.0 : 14.0)
    }
    
    //
    //  value
    //
    class var icFont3: UIFont {
        
        return UIFont.fontForSize(size: SystemConfiguration.isiPad() ? 14.0 : 12.0)
    }
    
    //
    //  value for sepecial
    //
    class var icFont3X: UIFont {
        
        return UIFont.fontForSize(size: SystemConfiguration.isiPad() ? 12.0 : 10.0)
    }
    
    //
    //  tiny-value
    //
    class var icFont4: UIFont {
        
        return UIFont.fontForSize(size: SystemConfiguration.isiPad() ? 10.0 : 8.5)
    }
    
    //
    //  Big-Title
    //
    class var icFont5: UIFont {
        
        return UIFont.specialEmphasisFontForSize(size: SystemConfiguration.isiPad() ? 22.0 : 20.0)
    }
    
    //
    //  especially for today's font
    //
    class var icFont6: UIFont {
        
        return UIFont.emphasisFontForSize(size: SystemConfiguration.isiPad() ? 16.0 : 14.0)
    }
}
