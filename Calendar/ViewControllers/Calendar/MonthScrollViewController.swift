//
//  MonthScrollViewController.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/3/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

/*********************************************************************
 *
 *  class MonthScrollViewController
 *
 *********************************************************************/

class MonthScrollViewController: BaseViewController, UIScrollViewDelegate {
    
    var currentMonthView: MonthView?
    var previousMonthView: MonthView?
    var nextMonthView: MonthView?
    var startMonth: Month?
    
    private let defaultMonthsCount = MonthManager.sharedManager.allMonthCount()    // default max count of
    private let pageWidth = CalendarViewDefinition.monthViewFrame().width   // we make scroll view as paging mode
    private var needHelpToRefreshScrollViewContentAfterScrollAnimation = false
    
    //
    //  lazy scroll view
    //
    lazy var scrollView: UIScrollView = {
        
        [unowned self] in
    
        let retScrollView = UIScrollView.init(frame: CalendarViewDefinition.monthViewFrame())
        retScrollView.contentSize = CGSize(width: self.pageWidth * CGFloat(self.defaultMonthsCount), height: retScrollView.bounds.height)
        retScrollView.backgroundColor = UIColor.icWhite
        retScrollView.decelerationRate = UIScrollViewDecelerationRateFast   // do not move too fast, so that 3 month view can't handle scrolling
        retScrollView.delegate = self
        retScrollView.alwaysBounceVertical = false
        retScrollView.alwaysBounceHorizontal = true
        retScrollView.showsVerticalScrollIndicator = false
        retScrollView.showsHorizontalScrollIndicator = false
        
        return retScrollView
    }()

    weak var calendarDelegate: CalendarDelegate?
    
    init(month: Month, calendarDelegate: CalendarDelegate?) {
        
        self.startMonth = month
        self.calendarDelegate = calendarDelegate

        super.init(nibName:nil, bundle:nil)
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
        
        //
        //  init scroll view by max month view frame
        //
        self.view.frame = CalendarViewDefinition.monthViewFrame()
        self.scrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        //
        //  init first three months view
        //
        if let thisMonth = self.startMonth
        {
            self.refreshScrollContentViewBy(month: thisMonth)
        }
        
        self.view.addSubview(self.scrollView)
    }
    
    //
    // MARK: - Private Method
    //
    
    private func refreshScrollContentViewBy(month: Month) {
        
        //
        //  remove all existed month view
        //
        self.currentMonthView?.removeFromSuperview()
        self.currentMonthView = nil
        self.nextMonthView?.removeFromSuperview()
        self.nextMonthView = nil
        self.previousMonthView?.removeFromSuperview()
        self.previousMonthView = nil
        
        //
        //  init first three months view
        //
        self.currentMonthView = MonthView.init(month: month, frame: CalendarViewDefinition.monthViewFrame(weeksCount: month.weeks!.count), delegate: self.calendarDelegate)
        self.currentMonthView?.frame = CGRect(x: self.pageWidth * CGFloat(MonthManager.sharedManager.monthIndexInAll(month) - 1), y: self.currentMonthView!.frame.origin.y, width: self.currentMonthView!.bounds.width, height: self.currentMonthView!.bounds.height)
        self.scrollView.addSubview(self.currentMonthView!)
        
        //
        //  tell delegate current month is changed
        //
        self.calendarDelegate?.currentMonthChanged(changToMonth: self.currentMonthView!.month!)
        
        if let nextMonth = month.nextMonth
        {
            self.nextMonthView = MonthView.init(month: nextMonth, frame: CalendarViewDefinition.monthViewFrame(weeksCount: nextMonth.weeks!.count), delegate: self.calendarDelegate)
            self.nextMonthView?.frame = CGRect(x: self.currentMonthView!.frame.origin.x + self.currentMonthView!.frame.width, y: self.self.currentMonthView!.frame.origin.y, width: self.nextMonthView!.frame.width, height: self.nextMonthView!.frame.height)
            self.scrollView.addSubview(self.nextMonthView!)
        }
        
        if let previousMonth = month.previousMonth
        {
            self.previousMonthView = MonthView.init(month: previousMonth, frame: CalendarViewDefinition.monthViewFrame(weeksCount: previousMonth.weeks!.count), delegate: self.calendarDelegate)
            self.previousMonthView?.frame = CGRect(x: self.currentMonthView!.frame.origin.x - self.currentMonthView!.frame.width, y: self.self.currentMonthView!.frame.origin.y, width: self.previousMonthView!.frame.width, height: self.previousMonthView!.frame.height)
            self.scrollView.addSubview(self.previousMonthView!)
        }
        
        //
        //  move scroll view's visable rect to current month view, and set offset without animation
        //
        self.scrollView.contentOffset = CGPoint(x: self.currentMonthView!.frame.origin.x, y: 0)
    }
    
    private func refreshNextMonthViews() {
        
        //
        //  if next month is nil, means already the last month in all months, so don't need to refresh
        //
        if (nil != self.nextMonthView)
        {
            //
            //  remove previou month view
            //
            self.previousMonthView?.removeFromSuperview()
            self.previousMonthView = nil
            
            self.previousMonthView = self.currentMonthView
            self.currentMonthView = self.nextMonthView
            
            //
            //  tell delegate current month is changed
            //
            self.calendarDelegate?.currentMonthChanged(changToMonth: self.currentMonthView!.month!)
            
            //
            //  create new next month view, and add into scroll view, meanwhile check if need to enlarge scrollview
            //
            if let newNextMonth = self.nextMonthView?.month?.nextMonth
            {
                debugPrint("Create next month view, month \(newNextMonth.id)")
                
                self.nextMonthView = MonthView.init(month: newNextMonth, frame: CalendarViewDefinition.monthViewFrame(weeksCount: newNextMonth.weeks!.count), delegate: self.calendarDelegate)
                self.nextMonthView?.frame = CGRect(x: self.currentMonthView!.frame.origin.x + self.currentMonthView!.frame.width, y: self.self.currentMonthView!.frame.origin.y, width: self.nextMonthView!.frame.width, height: self.nextMonthView!.frame.height)
                
                //
                //  add to scroll view
                //
                self.scrollView.addSubview(self.nextMonthView!)
            }
            //
            //  if this refresh is the last month in all months
            //
            else
            {
                self.nextMonthView = nil
            }
        }
    }
    
    private func refreshPreviousMonthViews() {
        
        //
        //  if previous month is nil, means already the first month in all months, so don't need to refresh
        //
        if (nil != self.previousMonthView)
        {
            //
            //  remove previou month view
            //
            self.nextMonthView?.removeFromSuperview()
            self.nextMonthView = nil
            
            self.nextMonthView = self.currentMonthView
            self.currentMonthView = self.previousMonthView
            
            //
            //  tell delegate current month is changed
            //
            self.calendarDelegate?.currentMonthChanged(changToMonth: self.currentMonthView!.month!)
            
            //
            //  create new previous month view, and add into scroll view, meanwhile check if previous view exceed default months bounds
            //
            if let newPreviousMonth = self.previousMonthView?.month?.previousMonth
            {
                debugPrint("Create previous month view, month \(newPreviousMonth.id)")
                
                self.previousMonthView = MonthView.init(month: newPreviousMonth, frame: CalendarViewDefinition.monthViewFrame(weeksCount: newPreviousMonth.weeks!.count), delegate: self.calendarDelegate)
                self.previousMonthView?.frame = CGRect(x: self.currentMonthView!.frame.origin.x - self.currentMonthView!.frame.width, y: self.self.currentMonthView!.frame.origin.y, width: self.previousMonthView!.frame.width, height: self.previousMonthView!.frame.height)
                
                //
                //  add to scroll view
                //
                self.scrollView.addSubview(self.previousMonthView!)
            }
            //
            //  if this refresh is the first month in all months
            //
            else
            {
                self.previousMonthView = nil
            }
        }
    }
    
    //
    // MARK: - Public Method
    //
    
    //
    //  scroll to today's month view, incase today is changed, so should calculate today's month again
    //
    func scrollToToday(_ today: Day) {
        
        //
        //  change startMonth incase today changed
        //
        self.startMonth = today.belongMonth
        
        //
        //  scroll to new start Month within today, we assume startMonth must have
        //
        self.scrollView.scrollRectToVisible(CGRect(x: self.pageWidth * CGFloat(MonthManager.sharedManager.monthIndexInAll(self.startMonth!) - 1), y: 0, width: self.scrollView.bounds.width, height: self.scrollView.bounds.height), animated: true)
        
        //
        //  A very complex logic to fix refresh and scroll to today
        //  in order to refresh today, make selection, we do such things
        //  1. calendar contorller deselected selected day view, and de-today today's view
        //  2. calendar controller set day obj and make today as selected, but at this moment we don't make that new today's day view as selected as today
        //  3. calendar controller call scroll to today here
        //  4. month view controller try to refresh today by today id before scroll, so at this moment, the current, next, previous month view may be all not the today's month view, if so will be corrected to calendar view in re-init stage, so here we just check these 3 month view
        //  5. calendar controller receive func todayDayView(dayView: DayView), and get the new today view
        //  6. calendar controller set today's dayview as selected, so the day view can setNeedDisplay() to make self as selected
        //
        if nil != self.currentMonthView
        {
            self.currentMonthView!.refreshTodayBy(id: today.id)
        }
            
        if nil != self.previousMonthView
        {
            self.previousMonthView!.refreshTodayBy(id: today.id)
        }
        
        if nil != self.nextMonthView
        {
            self.nextMonthView!.refreshTodayBy(id: today.id)
        }
    }
    
    //
    // MARK: - UIScrollView delegate
    //
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //
        //  set scroll view as paging for each month
        //
        let pageIndex: CGFloat = floor((scrollView.contentOffset.x - self.pageWidth / 2) / self.pageWidth) + 1  // min is 0
        
        self.scrollView.scrollRectToVisible(CGRect(x: pageWidth * pageIndex, y: 0, width: pageWidth, height: self.scrollView.bounds.height), animated: true)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        debugPrint("scrollViewDidEndScrollingAnimation")
        
        //
        //  sometime when scroll too fast, we will miss month by month increasment in scrollViewDidScroll, so I decide to check last stop index and create the month agian
        //
        if self.needHelpToRefreshScrollViewContentAfterScrollAnimation
        {
            let pageIndex: CGFloat = floor((scrollView.contentOffset.x - self.pageWidth / 2) / self.pageWidth) + 1   // min is 0
            
            if let month = MonthManager.sharedManager.monthAtIndex(Int(pageIndex))
            {
                self.refreshScrollContentViewBy(month: month)
            }
            
            self.needHelpToRefreshScrollViewContentAfterScrollAnimation = false
        }
        else
        {
            //
            //  set scroll view as paging for each month
            //
            let pageIndex: CGFloat = floor((scrollView.contentOffset.x - self.pageWidth / 2) / self.pageWidth) + 1  // min is 0
            
            self.scrollView.scrollRectToVisible(CGRect(x: pageWidth * pageIndex, y: 0, width: pageWidth, height: self.scrollView.bounds.height), animated: true)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //
        //  if no decelerate, I need to do paging here
        //
        if !decelerate
        {
            let pageIndex: CGFloat = floor((scrollView.contentOffset.x - self.pageWidth / 2) / self.pageWidth) + 1
            
            self.scrollView.scrollRectToVisible(CGRect(x: pageWidth * pageIndex, y: 0, width: pageWidth, height: self.scrollView.bounds.height), animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if let currentMonthView = self.currentMonthView
        {
            let interval = CGFloat(currentMonthView.frame.origin.x - scrollView.contentOffset.x)
            
            debugPrint(interval)
            
            //
            //  if scroll larger than half of current month view, need to prepare next month or previous month
            //
            if interval > 0.0, interval > pageWidth / 2
            {
                if interval > pageWidth * 1.5
                {
                    debugPrint("I need help, scroll too fast")
                    self.needHelpToRefreshScrollViewContentAfterScrollAnimation = true
                }
                
                self.refreshPreviousMonthViews()
            }
            else if interval < 0.0, abs(interval) > pageWidth / 2
            {
                if abs(interval) > pageWidth * 1.5
                {
                    debugPrint("I need help, scroll too fast")
                    self.needHelpToRefreshScrollViewContentAfterScrollAnimation = true
                }
                
                self.refreshNextMonthViews()
            }
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
