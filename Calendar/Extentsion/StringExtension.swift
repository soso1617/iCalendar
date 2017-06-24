//
//  StringExtension.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/30/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
