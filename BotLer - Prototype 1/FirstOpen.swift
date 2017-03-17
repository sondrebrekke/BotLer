//
//  FirstOpen.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 01.03.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class FirstOpen : UIViewController, UITableViewDataSource{
    

    @IBOutlet weak var tabell: UITableView!
    
    var ids: [String] = []
    var names: [String] = []
    var subjects: [String] = []
    var descriptions: [String] = []
    var deadlines: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            ChooseSubject.mineFag = UserDefaults.standard.array(forKey: "Key") as! [String]
        }
        
        let url=URL(string:"http://folk.ntnu.no/sondrbre/")
        do {
            let allContactsData = try Data(contentsOf: url!)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            if let arrJSON = allContacts["data"] {
                for index in 0...arrJSON.count-1 {
                    
                    let aObject = arrJSON[index] as! [String : AnyObject]
                    
                    ids.append(aObject["id"] as! String)
                    names.append(aObject["name"] as! String)
                    subjects.append(aObject["subject"] as! String)
                    descriptions.append(aObject["description"] as! String)
                    deadlines.append(aObject["deadline"] as! String)
                }
            }
            
            self.tabell.reloadData()
        }
        catch {
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = names[indexPath.row] + " - " + subjects[indexPath.row]
        return cell
    }
    
}
