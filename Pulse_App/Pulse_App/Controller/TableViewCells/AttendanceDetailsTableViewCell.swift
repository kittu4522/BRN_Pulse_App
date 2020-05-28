//
//  AttendanceDetailsTableViewCell.swift
//  Pulse_Project
//
//  Created by RAM on 12/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit

class AttendanceDetailsTableViewCell: UITableViewCell
{
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var dateLBL: UILabel!
    @IBOutlet weak var dayLBL: UILabel!
    
    
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var checkInLBL: UILabel!
    @IBOutlet weak var checkOutLBL: UILabel!
    
    @IBOutlet weak var timeSpentLBL: UILabel!
    @IBOutlet weak var spentSummaryLBL: UILabel!
    
    
    @IBOutlet weak var pointsEarnedLBL: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        cellView.setShadow()
        dataView.setShadow()

        // Configure the view for the selected state
    }
    
}
