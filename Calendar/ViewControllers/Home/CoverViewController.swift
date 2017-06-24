//
//  CoverViewController.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/6/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

/*********************************************************************
 *
 *  class CoverViewController
 *
 *********************************************************************/

class CoverViewController: BaseViewController {
    
    lazy var backgroundImageView: UIImageView = {
        
        let retImageView = UIImageView.init()
        
        switch UIDevice.current.iPhoneDeviceScreen
        {
            case .iPhone5:
                retImageView.image = UIImage.init(named: "background5")
            case .iPhone6Plus:
                retImageView.image = UIImage.init(named: "background6plus")
            case .iPhone6:
                retImageView.image = UIImage.init(named: "background6")
        }
        
        retImageView.frame = self.view.bounds
        retImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return retImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initialFromLoad() {
        
        //
        //  add background image view
        //
        self.view.addSubview(self.backgroundImageView)
        
        //
        //  add version label
        //
        let marginToBottom: CGFloat = 10.0
        let versionLabel = UILabel.init()
        versionLabel.text = String.init(format: "Version".localized, Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")
        versionLabel.textColor = UIColor.icWhite
        versionLabel.font = UIFont.icFont2
        versionLabel.sizeToFit()
        versionLabel.frame = CGRect(x: (self.view.bounds.width - versionLabel.bounds.width) / 2.0, y: self.view.bounds.height - versionLabel.bounds.height - marginToBottom, width: versionLabel.bounds.width, height: versionLabel.bounds.height)
        self.view.addSubview(versionLabel)
        
        //
        //  add initializing label
        //
        let marginAfterCenter: CGFloat = 100.0
        let initLabel = UILabel.init()
        initLabel.text = "Initializing".localized
        initLabel.textColor = UIColor.icWhite
        initLabel.font = UIFont.icFont5
        initLabel.sizeToFit()
        initLabel.frame = CGRect(x: (self.view.bounds.width - initLabel.bounds.width) / 2.0, y: (self.view.bounds.height - initLabel.bounds.height) / 2.0 + marginAfterCenter, width: initLabel.bounds.width, height: initLabel.bounds.height)
        self.view.addSubview(initLabel)
        
        DispatchQueue.global().async {
            
            SystemConfiguration.checkIsFirstRunAndBackToMainThread {
                
                self.showHome()
            }
        }
    }
    
    private func showHome() {
        
        //
        //  switch root view controller to home view controller
        //
        let homeViewController = HomeViewController()
        let homeNavigationController = BaseNavigationController.init(rootViewController: homeViewController)
        
        //
        //  flip animation
        //
        UIView.beginAnimations("", context: nil)
        UIView.setAnimationCurve(.easeInOut)
        UIView.setAnimationDuration(0.75)
        UIApplication.shared.windows[0].rootViewController = homeNavigationController
        UIView.setAnimationTransition(.flipFromRight, for: UIApplication.shared.windows[0], cache: false)
        UIView.commitAnimations()
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
