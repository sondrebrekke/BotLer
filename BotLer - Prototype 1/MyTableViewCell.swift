//
//  MyTableViewCell.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 22.02.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    

    //This class defines how the cells on the 'select subject'-table are designed and implementet.
    
    //Defines the switch-button and the text-field for the subjectname.
    @IBOutlet weak var svitsj: UISwitch!
    @IBOutlet weak var content: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // Configure the view for the selected state
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //Runs when the switch is clicked, and set's it either to on or off.
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
