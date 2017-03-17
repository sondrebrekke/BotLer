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
    static var completedAssignments = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        let launchedBefore2 = UserDefaults.standard.bool(forKey: "launchedBefore2")
        if launchedBefore  {
            ChooseSubject.mineFag = UserDefaults.standard.array(forKey: "Key") as! [String]
            ChooseSubject.mineFagKoder = [String]()
            if(ChooseSubject.mineFag.count>0){
                for index in 0...ChooseSubject.mineFag.count-1{
                    ChooseSubject.mineFagKoder.append(ChooseSubject.mineFag[index].components(separatedBy: " ")[0])
                }
            }
        }
        if launchedBefore2{
            FirstOpen.completedAssignments = UserDefaults.standard.array(forKey: "Nøkkel") as! [String]
        }
        let url=URL(string:"http://folk.ntnu.no/sondrbre/index.php")
        do {
            let allContactsData = try Data(contentsOf: url!)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            if let arrJSON = allContacts["data"]{
                for index in 0...arrJSON.count-1 {
                    
                    let aObject = arrJSON.objectAt(index) as! [String : AnyObject]
                    if(ChooseSubject.mineFagKoder.contains(aObject["subject"] as! String) && !(FirstOpen.completedAssignments.contains(aObject["id"] as! String))){
                        ids.append(aObject["id"] as! String)
                        names.append(aObject["name"] as! String)
                        subjects.append(aObject["subject"] as! String)
                        descriptions.append(aObject["description"] as! String)
                        deadlines.append(aObject["deadline"] as! String)
                    }
                }
            }
            
            self.tabell.reloadData()
        }
        catch {
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    static func completeAssignment(){
        UserDefaults.standard.set(FirstOpen.completedAssignments, forKey: "Nøkkel")
        UserDefaults.standard.set(true, forKey: "launchedBefore2")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:AssignmentCell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! AssignmentCell
        cell.SubjectCode?.text = subjects[indexPath.row]
        cell.Desc?.text = descriptions[indexPath.row]
        cell.Name?.text = names[indexPath.row]
        cell.Deadline?.text = deadlines[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let complete = UITableViewRowAction(style: .normal, title: "Complete") { action, index in
            FirstOpen.completedAssignments.append(self.ids[indexPath.row]+"")
            //FirstOpen.completedAssignments = [String]()
            FirstOpen.completeAssignment()
            self.ids.remove(at: indexPath.row)
            self.names.remove(at: indexPath.row)
            self.subjects.remove(at: indexPath.row)
            self.descriptions.remove(at: indexPath.row)
            self.deadlines.remove(at: indexPath.row)
            self.tabell.reloadData()
        }
        complete.backgroundColor = UIColor.green
        
        return [complete]
    }
    
}
