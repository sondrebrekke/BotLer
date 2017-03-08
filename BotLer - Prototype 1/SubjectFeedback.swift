//
//  SubjectFeedback.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 01.03.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class SubjectFeedback: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return ChooseSubject.mineFag.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = ChooseSubject.mineFag[indexPath.row]
        return cell
    }

    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        print(ChooseSubject.mineFag[indexPath.row])
    }

}
