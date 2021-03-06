//
//  BaseTableViewController.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/5/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    //
    //  sub-class could use this to hide/dispaly navigation bar
    //
    var bNeedTransparentNavigationBar = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //
        //  set view default background color
        //
        self.view.backgroundColor = UIColor.icBackground;
        
        //
        //  do customization for each sub-class
        //
        self.initialFromLoad()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
