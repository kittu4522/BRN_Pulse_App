//
//  TaskStatusTableViewCell.swift
//  Pulse_Project
//
//  Created by RAM on 12/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit

class TaskStatusTableViewCell: UITableViewCell
{

    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var snoLBL: UILabel!
    
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var taskIDLBL: UILabel!
    @IBOutlet weak var taskTypeLBL: UILabel!
    
    @IBOutlet weak var requirementsTxtView: UITextView!
    
    @IBOutlet weak var issueLBL: UILabel!
    @IBOutlet weak var buildToStoreLBL: UILabel!
    @IBOutlet weak var deadLineLBL: UILabel!
    @IBOutlet weak var fileSizeLBL: UILabel!
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
