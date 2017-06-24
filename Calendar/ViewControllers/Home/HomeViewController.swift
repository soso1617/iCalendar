//
//  HomeViewController.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/30/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

/*********************************************************************
 *
 *  class HomeViewController
 *
 *********************************************************************/

class HomeViewController: BaseViewController {
    
    var calendarViewController = CalendarViewController()
    var agendaViewController = AgendaViewController()
    var selectedDate = UILabel.init()

    private let dateStringFormat = "  %@, %@"
    
    deinit {
        
        //
        //  remove observing for day changed event
        //
        NotificationCenter.default.removeObserver(self, name: .init(CalendarViewDefinition.kNotificationNameDayChanged), object: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nil, bundle: nil)

        //
        //  register observing for day changed event
        //
        NotificationCenter.default.addObserver(forName: .init(CalendarViewDefinition.kNotificationNameDayChanged), object: nil, queue: OperationQueue.init()) { (notification) in
            
            debugPrint("Day changed")
            
            if let day = notification.object as? Day
            {
                //
                //  change agenda view in main queue
                //
                DispatchQueue.main.async {
                    
                    //
                    //  set date string
                    //
                    self.selectedDate.text = String.init(format: self.dateStringFormat, day.nameInWeek!, DateConversion.date2LongStringFromDate(day.date! as Date))
                    
                    //
                    //  get new agenda view
                    //
                    self.agendaViewController.setNewDayAndReload(day)
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initialFromLoad() {
        
        self.title = "Home_Title".localized
        
        //
        //  init calendar view frame
        //
        self.calendarViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: kHeaderTitleViewHeight + CalendarViewDefinition.monthViewFrame().height)
        self.calendarViewController.view.autoresizingMask = [.flexibleBottomMargin, .flexibleWidth]
        self.view.addSubview(self.calendarViewController.view)
        
        //
        //  init selected date
        //
        let selectedDateHeight: CGFloat = 18.0
        self.selectedDate.textColor = UIColor.icWhite
        self.selectedDate.font = UIFont.icFont2
        self.selectedDate.frame = CGRect(x: 0, y: self.calendarViewController.view.frame.origin.y + self.calendarViewController.view.frame.height, width: self.view.bounds.width, height: selectedDateHeight)
        self.selectedDate.backgroundColor = UIColor.icGrayishBlue
        
        //
        //  set default date string
        //
        if let day = DayManager.sharedManager.today()
        {
            self.selectedDate.text = String.init(format: self.dateStringFormat, day.nameInWeek!, DateConversion.date2LongStringFromDate(day.date! as Date))
        }
        
        self.view.addSubview(self.selectedDate)
        
        //
        //  init agenda view frame
        //
        self.agendaViewController.view.frame = CGRect(x: 0, y: self.calendarViewController.view.frame.origin.y + self.calendarViewController.view.frame.height + selectedDateHeight, width: self.view.bounds.size.width, height: self.view.bounds.height - (kHeaderTitleViewHeight + CalendarViewDefinition.monthViewFrame().height + selectedDateHeight))
        self.agendaViewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.agendaViewController.setNewDayAndReload(DayManager.sharedManager.today()!)
        self.view.addSubview(self.agendaViewController.view)
        
        //
        //  add cancel button
        //
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Btn_Today".localized, style: .done, target: self, action: #selector(self.go2Today))
    }
    
    @objc private func go2Today() {
        
        self.calendarViewController.go2Today()
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
