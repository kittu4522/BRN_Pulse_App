//
//  PersonalDetailsTableViewCell.swift
//  Pulse_Project
//
//  Created by RAM on 12/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit

class PersonalDetailsTableViewCell: UITableViewCell
{
    @IBOutlet weak var titleLBL: UILabel!
    
    @IBOutlet weak var valueLBL: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        
        bgView.setShadow()
        
        
        
       
        
        // Configure the view for the selected state
    }
    
}
