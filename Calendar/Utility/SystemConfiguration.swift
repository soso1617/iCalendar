//
//  SystemConfiguration.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/30/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

/*********************************************************************
 *
 *  class SystemConfiguration
 *
 *********************************************************************/

let kDefaultStatusBarHeight: CGFloat = 20.0
let kDefaultNavigationBarHeight: CGFloat = 44.0
let kDefaultHeaderHeight: CGFloat = 64.0

let kUserDefaultIsFirstRun = "isFirstRun"
let kUserDefaultDBYears = "dbYears"
let kUserDefaultFromYear = "fromYear"
let kUserDefaultToYear = "toYear"

class SystemConfiguration {
    
    class func isiPad() -> Bool {
        
        switch UIDevice.current.userInterfaceIdiom
        {
            case .pad:
                return true
                //
                //  others as iPhone
            //
            default:
                return false
        }
    }
    
    class func screenSize() -> CGSize {
        
        return UIScreen.main.bounds.size
    }
    
    class func checkIsFirstRunAndBackToMainThread(_ completion: (() -> Void)?) {
        
        //
        //  once you changed default years ranged, please delete the app and reinstall
        //
        let userDefaults = UserDefaults.standard
        let fromYear = 2010
        let toYear = 2020
        
        if userDefaults.bool(forKey: kUserDefaultIsFirstRun) == false
        {
            //
            // create initialized calendar
            //
            _ = CalendarCoreDataInitializer.initializeCalendar(fromYear: fromYear, toYear: toYear, completion: { (bSuccess) in
                
                if bSuccess
                {
                    //
                    // update the flag indicator
                    //
                    userDefaults.set(true, forKey: kUserDefaultIsFirstRun)
                    userDefaults.set((toYear - fromYear + 1), forKey: kUserDefaultDBYears)
                    userDefaults.set(fromYear, forKey: kUserDefaultFromYear)
                    userDefaults.set(toYear, forKey: kUserDefaultToYear)
                    
                    DispatchQueue.main.async(execute: { 
                        completion?()
                    })
                }
                else
                {
                    SystemAlert.showInitialErrorAndExit()
                }
            })
        }
        else
        {
            DispatchQueue.main.async(execute: {
                completion?()
            })
        }
    }
}
