//
//  AgendaTableViewCell.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 5/6/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import UIKit

/*********************************************************************
 *
 *  class AgendaTableViewCell
 *
 *********************************************************************/

class AgendaTableViewCell: UITableViewCell {
    
    let attendeesLabel = UILabel.init()
    let shortDescriptionLabel = UILabel.init()
    let startTimeLabel = UILabel.init()
    let endTimeLabel = UILabel.init()
    let stautsImageView = UIImageView.init()
    let locationLabel = UILabel.init()
    let durationLabel = UILabel.init()
    let typeImageView = UIImageView.init()
    let attendeeImageView = UIImageView(image: UIImage.init(named: "attendee"))
    let statusImageTopBar = UIView.init()
    let statusImageBottomBar = UIView.init()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.attendeesLabel.font = UIFont.icFont3
        self.attendeesLabel.textColor = UIColor.icTextColor
        self.attendeesLabel.numberOfLines = 2
        
        self.locationLabel.font = UIFont.icFont3
        self.locationLabel.textColor = UIColor.icGray
        
        self.startTimeLabel.font = UIFont.icFont3X
        self.startTimeLabel.textColor = UIColor.icTextColor
        self.startTimeLabel.textAlignment = .right
        
        self.endTimeLabel.font = UIFont.icFont3X
        self.endTimeLabel.textColor = UIColor.icTextColor
        self.endTimeLabel.textAlignment = .right
        
        self.durationLabel.font = UIFont.icFont4
        self.durationLabel.textColor = UIColor.icGray
        self.durationLabel.textAlignment = .right
        
        self.shortDescriptionLabel.font = UIFont.icFont2
        self.shortDescriptionLabel.textColor = UIColor.icTextColor
        self.shortDescriptionLabel.numberOfLines = 0
        
        self.statusImageTopBar.backgroundColor = UIColor.icSeparator
        self.statusImageBottomBar.backgroundColor = UIColor.icSeparator
        
        //
        //  create autolayout
        //
        self.attendeesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.locationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.endTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.shortDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.durationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.stautsImageView.translatesAutoresizingMaskIntoConstraints = false
        self.typeImageView.translatesAutoresizingMaskIntoConstraints = false
        self.attendeeImageView.translatesAutoresizingMaskIntoConstraints = false
        self.statusImageTopBar.translatesAutoresizingMaskIntoConstraints = false
        self.statusImageBottomBar.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.attendeesLabel)
        self.contentView.addSubview(self.locationLabel)
        self.contentView.addSubview(self.startTimeLabel)
        self.contentView.addSubview(self.endTimeLabel)
        self.contentView.addSubview(self.shortDescriptionLabel)
        self.contentView.addSubview(self.durationLabel)
        self.contentView.addSubview(self.stautsImageView)
        self.contentView.addSubview(self.typeImageView)
        self.contentView.addSubview(self.attendeeImageView)
        self.contentView.addSubview(self.statusImageTopBar)
        self.contentView.addSubview(self.statusImageBottomBar)
        
        let marginX: CGFloat = 8.0
        let marginY: CGFloat = 12.0
        let anotherMarginY: CGFloat = 10.0
        let intervalY: CGFloat = 6.0
        let intervalX: CGFloat = 8.0
        let timeIntervalY: CGFloat = 4.0
        let verticalSeparatorWidth: CGFloat = 0.5
        let timeLabelWidth: CGFloat = 50.0
        let statusImageSize = CGSize(width: 12, height: 12)
        let typeImageSize = CGSize(width: 16, height: 16)
        let attendeeImageSize = CGSize(width: 16, height: 16)
        
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets(top: 0, left: marginX + timeLabelWidth + intervalX * 2 + statusImageSize.width, bottom: 0, right: 0)

        let metrics = ["marginX" : marginX, "anotherMarginY" : anotherMarginY, "marginY" : marginY, "timeIntervalY" : timeIntervalY, "statusSide" : statusImageSize.width, "typeSide" : typeImageSize.width, "timeWidth" : timeLabelWidth, "attendeeSide" : attendeeImageSize.width, "intervalX": intervalX, "intervalY": intervalY]
        let views: [String : Any] = ["descLabel" : self.shortDescriptionLabel,
                     "attendeesLabel" : self.attendeesLabel,
                     "startLabel" : self.startTimeLabel,
                     "endLabel" : self.endTimeLabel,
                     "durationLabel" : self.durationLabel,
                     "locationLabel" : self.locationLabel,
                     "statusImage" : self.stautsImageView,
                     "typeImage" : self.typeImageView,
                     "attendeeImage" : self.attendeeImageView,
                     "topImage" : self.statusImageTopBar,
                     "bottomImage" : self.statusImageBottomBar]
        
        let formatHString1 = "H:|-marginX-[startLabel(==timeWidth)]-intervalX-[statusImage(==statusSide)]-intervalX-[descLabel]-marginX-|"
        let formatHString2 = "H:[typeImage(==typeSide)]-intervalX-[locationLabel]-marginX-|"
        let formatHString3 = "H:[attendeeImage(==attendeeSide)]-intervalX-[attendeesLabel]-marginX-|"
        let formatVString1 = "V:|[topImage(==marginY)][statusImage(==statusSide)][bottomImage]|"
        let formatVString2 = "V:|-anotherMarginY-[descLabel]-intervalY-[attendeesLabel(>=attendeeSide)]-intervalY-[locationLabel(>=typeSide)]-marginY-|"
        let formatVString3 = "V:|-marginY-[startLabel]-timeIntervalY-[endLabel]-intervalY-[durationLabel]->=marginY-|"
        
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: formatHString1, options: [], metrics: metrics, views: views)
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: formatHString2, options: [], metrics: metrics, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: formatHString3, options: [], metrics: metrics, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: formatVString1, options: [], metrics: metrics, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: formatVString2, options: [], metrics: metrics, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: formatVString3, options: [], metrics: metrics, views: views))
        
        constraints.append(NSLayoutConstraint.init(item: self.endTimeLabel, attribute: .left, relatedBy: .equal, toItem: self.startTimeLabel, attribute: .left, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint.init(item: self.endTimeLabel, attribute: .width, relatedBy: .equal, toItem: self.startTimeLabel, attribute: .width, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint.init(item: self.durationLabel, attribute: .left, relatedBy: .equal, toItem: self.startTimeLabel, attribute: .left, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint.init(item: self.durationLabel, attribute: .width, relatedBy: .equal, toItem: self.startTimeLabel, attribute: .width, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint.init(item: self.stautsImageView, attribute: .centerY, relatedBy: .equal, toItem: self.startTimeLabel, attribute: .centerY, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint.init(item: self.typeImageView, attribute: .leading, relatedBy: .equal, toItem: self.shortDescriptionLabel, attribute: .leading, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint.init(item: self.typeImageView, attribute: .centerY, relatedBy: .equal, toItem: self.locationLabel, attribute: .centerY, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint.init(item: self.attendeeImageView, attribute: .leading, relatedBy: .equal, toItem: self.shortDescriptionLabel, attribute: .leading, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint.init(item: self.attendeeImageView, attribute: .centerY, relatedBy: .equal, toItem: self.attendeesLabel, attribute: .centerY, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint.init(item: self.statusImageTopBar, attribute: .centerX, relatedBy: .equal, toItem: self.stautsImageView, attribute: .centerX, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint.init(item: self.statusImageBottomBar, attribute: .centerX, relatedBy: .equal, toItem: self.stautsImageView, attribute: .centerX, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint.init(item: self.statusImageTopBar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: verticalSeparatorWidth))
        constraints.append(NSLayoutConstraint.init(item: self.statusImageBottomBar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: verticalSeparatorWidth))
        
        self.contentView.addConstraints(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        
        self.attendeesLabel.text = nil
        self.shortDescriptionLabel.text = nil
        self.startTimeLabel.text = nil
        self.endTimeLabel.text = nil
        self.locationLabel.text = nil
        self.durationLabel.text = nil
    }
    
    func setEvent(_ event: Event, selectedDay: Day, isFirst: Bool, isLast: Bool) {
        
        self.attendeesLabel.text = event.attendeesName
        self.startTimeLabel.text = event.displayStartTime(inDate: selectedDay.date! as Date)
        self.endTimeLabel.text = event.displayEndTime(inDate: selectedDay.date! as Date)
        self.shortDescriptionLabel.text = event.shortDesc
        self.durationLabel.text = event.duration
        self.locationLabel.text = event.locationDesc
        
        //
        //  set status image
        //
        self.setStatusImage(event.status())
        
        //
        //  set type image
        //
        if let type = EventType(rawValue: event.type ?? "")
        {
            self.setTypeImage(type)
        }
        
        self.statusImageTopBar.backgroundColor = UIColor.icSeparator
        self.statusImageBottomBar.backgroundColor = UIColor.icSeparator
        
        if isFirst
        {
            self.statusImageTopBar.backgroundColor = UIColor.clear
        }
        
        if isLast
        {
            self.statusImageBottomBar.backgroundColor = UIColor.clear
        }
    }
    
    //
    //  set differen color by status
    //  green == now, yellow == notstarted, gray == passed
    //
    private func setStatusImage(_ status: EventStatus) {
        
        switch status
        {
            case .AtNow:
                self.stautsImageView.image = UIImage.init(named: "greenCircle")
            case .Passed:
                self.stautsImageView.image = UIImage.init(named: "grayCircle")
            case .NotStarted:
                self.stautsImageView.image = UIImage.init(named: "yellowCircle")
            default:
                self.stautsImageView.image = UIImage.init(named: "grayCircle")
        }
    }
    
    //
    //  set differen icon by type
    //  green == now, yellow == notstarted, gray == passed
    //
    func setTypeImage(_ type: EventType)
    {
        switch type
        {
            case .Call:
                self.typeImageView.image = UIImage.init(named: "call")
            case .Meeting:
                self.typeImageView.image = UIImage.init(named: "meeting")
            case .Outdoor:
                self.typeImageView.image = UIImage.init(named: "outdoor")
        }
    }
}
