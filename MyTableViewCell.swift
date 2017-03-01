//
//  MyTableViewCell.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 22.02.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {


    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var knapp: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func clicked(_ sender: Any) {
        if(knapp.backgroundColor == UIColor.green){
            knapp.backgroundColor = UIColor.red
            knapp.setTitle("Not selected",for: .normal)
            if(ChooseSubject.mineFag.contains(content.text!)){
                let indeks = ChooseSubject.mineFag.index(of: content.text!)
                ChooseSubject.mineFag.remove(at: indeks!)
            }
        }
        else{
            knapp.backgroundColor = UIColor.green
            knapp.setTitle("Selected",for: .normal)
            ChooseSubject.mineFag.append(content.text!)
        }
        print(ChooseSubject.mineFag)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
