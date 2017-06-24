//
//  SystemUtility.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/1/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

class SystemUtility {
    
    //
    //  crystal style gradiant color image
    //
    class func crystalColorImage(crystalColor: UIColor, gradiantSize: CGSize, inset: UIEdgeInsets) -> UIImage {
        
        let imageSize = CGSize.init(width: gradiantSize.width, height: gradiantSize.height + inset.top + inset.bottom)
        
        let layer = CAGradientLayer()
        layer.frame = CGRect(origin: CGPoint.zero, size: gradiantSize)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        
        //
        //  get rgb
        //
        crystalColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        //
        //  create gradient color for image
        //
        layer.colors = [UIColor(red: red + 0.2, green: green + 0.2, blue: blue + 0.2, alpha: 1).cgColor,
                        UIColor(red: red + 0.1, green: green + 0.1, blue: blue + 0.1, alpha: 1).cgColor,
                        crystalColor.cgColor,
                        crystalColor.cgColor,
                        crystalColor.cgColor]
        layer.locations = [0.0, 0.3, 0.7, 0.9, 1.0]
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        
        //
        //  begin image
        //
        UIGraphicsBeginImageContext(imageSize)
        
        //
        //  draw top insect with one color
        //
        UIGraphicsGetCurrentContext()?.setFillColor(layer.colors?.first as! CGColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(origin: CGPoint.zero, size: CGSize(width: imageSize.width, height: inset.top)))
        UIGraphicsGetCurrentContext()?.translateBy(x: 0, y: inset.top)
        
        //
        //  draw graident
        //
        layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsGetCurrentContext()?.translateBy(x: 0, y: -inset.top)
        
        //
        //  draw bottom insect with one color
        //
        UIGraphicsGetCurrentContext()?.setFillColor(layer.colors?.last as! CGColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(origin: CGPoint.init(x: 0, y: inset.top + gradiantSize.height), size: CGSize(width: imageSize.width, height: inset.bottom)))
        
        //
        //  draw highlight
        //
        UIGraphicsGetCurrentContext()?.setFillColor(UIColor.init(white: 0, alpha: 0.1).cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(origin: CGPoint.zero, size: imageSize))
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return outputImage!
    }
}
