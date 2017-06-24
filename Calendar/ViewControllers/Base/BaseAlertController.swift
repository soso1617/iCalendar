//
//  BaseAlertController.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/30/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

/*********************************************************************
 *
 *  class BaseAlertController
 *
 *********************************************************************/

class BaseAlertController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func show(animated :Bool) {
        
        if let presentedViewController = UIApplication.shared.windows[0].rootViewController?.presentedViewController
        {
            //
            //  present on modaling view controller
            //
            presentedViewController.present(self, animated: animated, completion: nil)
        }
        else
        {
            //
            //  present on root view controller
            //
            UIApplication.shared.windows[0].rootViewController?.present(self, animated: animated, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
