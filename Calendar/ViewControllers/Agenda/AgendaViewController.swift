//
//  AgendaViewController.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/5/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

/*********************************************************************
 *
 *  class AgendaViewController
 *
 *********************************************************************/

class AgendaViewController: BaseTableViewController {
    
    private let cellId = "CellId"
    var sortedEvents: Array<Event>?
    var day: Day? {
        
        didSet
        {
            self.sortedEvents = self.day?.sortedEvents()
        }
    }
    
    lazy var noDataView: UIView = {
        
        [unowned self] in
        
        let retView = UIView.init()
        retView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        retView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin]
        
        //
        //  add nodata label on view
        //
        let noDataLabel = UILabel.init()
        noDataLabel.font = UIFont.icFont5
        noDataLabel.text = "No_Event".localized
        noDataLabel.textColor = UIColor.icPinkish
        noDataLabel.backgroundColor = UIColor.clear
        noDataLabel.textAlignment = .center
        noDataLabel.frame = retView.bounds
        noDataLabel.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin]
        
        retView.addSubview(noDataLabel)
        
        return retView
    }()
    
    convenience init() {
        
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(day: Day) {
        
        self.day = day
        self.sortedEvents = self.day?.sortedEvents()
        
        super.init(style: .plain)
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func initialFromLoad() {
        
        self.tableView.backgroundColor = UIColor.icWhite
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero) // set this for remove separator in empty cell
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = UIColor.icSeparator
        
        //
        //  register cell
        //
        self.tableView.register(AgendaTableViewCell.classForCoder(), forCellReuseIdentifier: self.cellId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNewDayAndReload(_ day: Day) {
        
        self.day = day
        
        self.tableView.reloadData()
        
        //
        //  show no data
        //
        if self.sortedEvents?.count ?? 0 > 0
        {
            self.noDataView.removeFromSuperview()
        }
        else
        {
            self.noDataView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            self.tableView.addSubview(self.noDataView)
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

    //
    // MARK: TableView Delegate
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.sortedEvents?.count ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let retCell = tableView.dequeueReusableCell(withIdentifier: self.cellId) as! AgendaTableViewCell
        
        if let event = self.sortedEvents?[indexPath.row]
        {
            retCell.setEvent(event, selectedDay: self.day!, isFirst: indexPath.row == 0, isLast: indexPath.row == self.sortedEvents!.count - 1)
        }
        
        return retCell
    }
    
    //
    //  auto height
    //
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    //
    //  auto height
    //
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
}
