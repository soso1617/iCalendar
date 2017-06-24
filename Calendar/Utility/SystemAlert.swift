//
//  SystemAlert.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/30/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

/*********************************************************************
 *
 *  class SystemAlert
 *  All of static error alert
 *
 *********************************************************************/

class SystemAlert {
    
    /**
     
     Show init error alert
     
     */
    class func showInitialErrorAndExit() {
        
        //
        //  show error and exit
        //
        let alert = BaseAlertController.init(title: "Error_Title".localized, message: "Boot_Failed_Message".localized, preferredStyle: .alert)
        
        //
        //  cancel button @ right
        //
        alert.addAction(UIAlertAction.init(title: "Btn_Exit".localized, style: .default, handler: { (action) in
            
            exit(0)
        }))
        
        alert.show(animated: true)
    }
    
    /**
     
     Show unknow error alert
     
     */
    class func showUnknowErrorAndExit() {
        
        //
        //  show error and exit
        //
        let alert = BaseAlertController.init(title: "Error_Title".localized, message: "Unknow_Error_Message".localized, preferredStyle: .alert)
        
        //
        //  cancel button @ right
        //
        alert.addAction(UIAlertAction.init(title: "Btn_Exit".localized, style: .default, handler: { (action) in
            
            exit(0)
        }))
        
        alert.show(animated: true)
    }
    
    /**
     
     Show common error with error message and title
     
     */
    class func showErrorMessage(_ message: String?, title: String?) {
        
        //
        //  show error and exit
        //
        let alert = BaseAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        //
        //  cancel button @ right
        //
        alert.addAction(UIAlertAction.init(title: "Btn_OK".localized, style: .default, handler: nil))
        
        alert.show(animated: true)
    }
    
    /**
     
     Show common error with error message and title, with default action handler
     
     */
    class func showErrorMessage(_ message: String?, title: String?, handler: ((UIAlertAction) -> Void)?) {
        
        //
        //  show error and exit
        //
        let alert = BaseAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        //
        //  cancel button @ right
        //
        alert.addAction(UIAlertAction.init(title: "Btn_OK".localized, style: .default, handler: handler))
        
        alert.show(animated: true)
    }
}
