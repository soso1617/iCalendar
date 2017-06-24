//
//  ArrayExtension.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/6/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation

extension Array {
    
    static func initFromFilePath(_ string: String) -> Array<AnyObject>? {
        
        return NSArray.init(contentsOfFile: string) as Array<AnyObject>?
    }
}
