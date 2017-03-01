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
            ChooseSubject.mineFag.append(content.text!)
        }
        else if (ChooseSubject.mineFag.contains(content.text!)){
            let indeks = ChooseSubject.mineFag.index(of: content.text!)
            ChooseSubject.mineFag.remove(at: indeks!)
        }
        ChooseSubject.lagre()
    }
}
