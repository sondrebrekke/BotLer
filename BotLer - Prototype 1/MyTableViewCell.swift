//
//  MyTableViewCell.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 22.02.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    

    @IBOutlet weak var svitsj: UISwitch!
    @IBOutlet weak var content: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func clicked(_ sender: Any) {
        if(svitsj.isOn){
            ChooseSubject.mySubjects.append(content.text!)
        }
        else if (ChooseSubject.mySubjects.contains(content.text!)){
            let indeks = ChooseSubject.mySubjects.index(of: content.text!)
            ChooseSubject.mySubjects.remove(at: indeks!)
        }
        ChooseSubject.saveForOffline()
    }
}
