//
//  AssignmentCell.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 17.03.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class AssignmentCell: UITableViewCell {
    
    
    @IBOutlet weak var Name: UITextView!
    @IBOutlet weak var Desc: UITextView!
    @IBOutlet weak var SubjectCode: UITextView!
    @IBOutlet weak var Deadline: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
