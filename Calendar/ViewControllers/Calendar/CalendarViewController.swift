//
//  CalendarViewController.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/2/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

enum DisplayMode
{
    case monthMode, weekMode
}

/*********************************************************************
 *
 *  class CalendarViewController
 *
 *********************************************************************/

class CalendarViewController: BaseViewController, CalendarDelegate {
    
    var selectedDay: Day?
    var selectedDayView: DayView?
    var todayView: DayView?
    
    //
    //  get today, week, month, year obj when init
    //
    var today: Day? = DayManager.sharedManager.today()
    var thisWeek: Week? = WeekManager.sharedManager.thisWeek()
    var thisMonth: Month? = MonthManager.sharedManager.thisMonth()
    var thisYear: Year? = YearManager.sharedManager.thisYear()
    var mode: DisplayMode = .weekMode   // default is week mode
    
    //
    //  lazy month scroll view
    //
    lazy var monthScrollViewController: MonthScrollViewController = {
    
        [unowned self] in
        
        if nil != self.thisMonth
        {
            let retMonthScrollViewController = MonthScrollViewController.init(month: self.thisMonth!, calendarDelegate: self)
            retMonthScrollViewController.view.frame = retMonthScrollViewController.view.frame.offsetBy(dx: 0, dy: kHeaderTitleViewHeight)
            retMonthScrollViewController.view.autoresizingMask = [.flexibleBottomMargin]
            
            return retMonthScrollViewController
        }
        else
        {
            fatalError(#function + "Can't create month scroll view, since this month is nil!")
        }
    }()
    
    //
    //  lazy header view
    //
    lazy var headerView: DateAndWeekTitleView = {
        
        [unowned self] in
        
        if nil != self.today
        {
            let retHeaderView = DateAndWeekTitleView.init(day: self.today!, frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: kHeaderTitleViewHeight), style: .default)
            retHeaderView.autoresizingMask = [.flexibleBottomMargin, .flexibleWidth]
            
            return retHeaderView
        }
        else
        {
            fatalError(#function + "Today is nil!")
        }
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
        //  add header view
        //
        self.view.addSubview(self.headerView)
        
        //
        //  first init, today is the current selected day
        //
        self.today?.isSelected = true
        self.selectedDay = today

        switch self.mode
        {
            case .monthMode:
                fallthrough
            default:
                self.view.addSubview(self.monthScrollViewController.view)
        }
    }
    
    //
    // MARK: - Private Method
    //
    
    //
    //  refresh today obj
    //  in case the user use the app pass two days
    //  be sure call this before view is going to refresh
    //
    private func refreshAndGo2Today() {
        
        //
        //  if today is not exist or changed
        //
        if let newToday = DayManager.sharedManager.today(), newToday != self.today
        {
            self.thisWeek = WeekManager.sharedManager.thisWeek()
            self.thisMonth = MonthManager.sharedManager.thisMonth()
            self.thisYear = YearManager.sharedManager.thisYear()
            
            //
            //  change today and todayview
            //
            self.today?.isToday = false
            self.todayView?.isToday = false
            
            //
            //  today's isToday will be set to true in DayManager.sharedManager.today()
            //
            self.today = newToday
            
            //
            //  self.todayView will be get after day view is awared
            //
            self.todayView = nil
        }
        
        //
        //  deselect current day and dayivew
        //
        self.selectedDay?.isSelected = false
        self.selectedDayView?.isSelected = false
        self.selectedDayView = nil
        
        //
        //  today's is selected as default
        //
        self.today?.isSelected = true
        self.selectedDay = today
        
        switch self.mode
        {
            case .monthMode:
                fallthrough
            default:
                self.monthScrollViewController.scrollToToday(self.today!)
        }
    }
    
    //
    // MARK: - Private Method
    //
    
    //
    //  make calendar go to today's dayview
    //
    func go2Today() {
        
        //
        //  first go to today, and make selected day back to today
        //
        self.refreshAndGo2Today()
    }

    //
    // MARK: - Calendar Delegate Method
    //
    
    //
    //  day selected
    //
    func selectedDay(day: Day, dayView: DayView) {
        
        //
        //  exchange selected day and isSelected
        //
        self.selectedDay?.isSelected = false
        self.selectedDay = day
        self.selectedDay?.isSelected = true
        
        //
        //  exchange selected day view, selectedDayView's isSelected will be awared by itself
        //
        self.selectedDayView?.isSelected = false
        self.selectedDayView = dayView
        self.selectedDayView?.isSelected = true
        
        //
        //  post notification to any observer need to know day changed
        //
        NotificationCenter.default.post(name: .init(CalendarViewDefinition.kNotificationNameDayChanged), object: self.selectedDay)
    }
    
    //
    //  tell delegate which dayView is for today's day obj
    //
    func todayDayView(dayView: DayView) {
        
        self.todayView = dayView
        
        if self.today?.isSelected ?? false
        {
            self.selectedDayView = dayView
            self.selectedDayView?.isSelected = true
            
            //
            //  post notification to any observer need to know day changed
            //  because move to today won't call selected day if this day view is not inited again
            //
            NotificationCenter.default.post(name: .init(CalendarViewDefinition.kNotificationNameDayChanged), object: self.selectedDay)
        }
    }
    
    //
    //  tell delegate current month is changed in month scroll view
    //
    func currentMonthChanged(changToMonth: Month) {
        
        if let day = changToMonth.days?.firstObject as? Day
        {
            self.headerView.day = day
        }
    }
}
