//
//  BaseViewController.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/30/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

/*********************************************************************
 *
 *  class BaseViewController
 *
 *********************************************************************/

class BaseViewController: UIViewController {

    //
    //  sub-class could use this to hide/dispaly navigation bar
    //
    var bNeedTransparentNavigationBar = false
    
    convenience init() {
        
        self.init(nibName:nil, bundle:nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //
        //  set view default background color
        //
        self.view.backgroundColor = UIColor.icBackground;
        
        //
        //  do customization for each sub-class
        //
        self.initialFromLoad()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //
        //  do customization of navigation bar
        //
        self.configNavigationBar()
    }
    
    //
    //  do initial here just like viewdidload, don't need super
    //
    func initialFromLoad() {
        
        //
        //  sub-class should do initialization here
        //
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    //
    //  config nagivation bar, u'd better not to do the following things here, set title, set bar button items
    //  subclass much load super
    //
    func configNavigationBar() {
        
        //
        //  this will layout content view below navigation bar, same as UIRectEdge.none
        //
        self.edgesForExtendedLayout = []
        
        //
        //  set navigation controller background transparent
        //
        if self.bNeedTransparentNavigationBar
        {
            self.edgesForExtendedLayout = self.hidesBottomBarWhenPushed ? UIRectEdge.all : UIRectEdge.top
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
        else
        {
            self.navigationController?.navigationBar.setBackgroundImage(SystemUtility.crystalColorImage(crystalColor: UIColor.icGreen, gradiantSize: CGSize.init(width: SystemConfiguration.screenSize().width, height: kDefaultHeaderHeight), inset: UIEdgeInsets.zero), for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
        }
        
        //
        //  clear back button item title
        //
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: ""
            , style: self.navigationItem.backBarButtonItem?.style ?? .plain, target: nil, action: nil)
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
