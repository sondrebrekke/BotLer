//
//  FirstOpen.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 01.03.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class FirstOpen : UIViewController, UITableViewDataSource{
    
    //The table is defined as 'tabell'
    @IBOutlet weak var tabell: UITableView!
    
    //Defines arrays where the information about the assignments will be stored.
    var ids: [String] = []
    var names: [String] = []
    var subjects: [String] = []
    var descriptions: [String] = []
    var deadlines: [String] = []
    
    //Defines a static array where your completed assignments will be saved so the statistic can easily be calculated.
    static var completedAssignments = [String]()
    
    //This function runs when page is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        let launchedBefore2 = UserDefaults.standard.bool(forKey: "launchedBefore2")
        let displayHelp = UserDefaults.standard.bool(forKey: "displayHelp")
        
        
        //If the app has been launched before, the user's subjects will be loaded from the info stored at the iOS device.
        if launchedBefore  {
            ChooseSubject.mySubjects = UserDefaults.standard.array(forKey: "mySubjects") as! [String]
            ChooseSubject.mySubjectCodes = [String]()
            if(ChooseSubject.mySubjects.count>0){
                for index in 0...ChooseSubject.mySubjects.count-1{
                    ChooseSubject.mySubjectCodes.append(ChooseSubject.mySubjects[index].components(separatedBy: " ")[0])
                }
            }
        }
        //Otherwise it should display a small tutorial.
        if !displayHelp {
            DispatchQueue.main.async
                {
                    let tutorial = UIAlertController(title: "Welcome to BotLer!", message: "Thank you for downloading BotLer. Please press the '?'-button on the top left to learn how you use the app.", preferredStyle: .alert)
                    tutorial.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(tutorial, animated: true, completion: nil)
            }
            UserDefaults.standard.set(true, forKey: "displayHelp")
        }
        //If the user has completed an assignment, the completed assignment are loaded.
        if launchedBefore2{
            FirstOpen.completedAssignments = UserDefaults.standard.array(forKey: "Nøkkel") as! [String]
        }
        
        //Defines the url of the page that contains all assignments
        let url=URL(string:"http://folk.ntnu.no/sondrbre/getAssignments.php")
        do {
            let allAssignmentsData = try Data(contentsOf: url!)
            let allAssignments = try JSONSerialization.jsonObject(with: allAssignmentsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            if let arrJSON = allAssignments["data"]{
                //Iterate through all the assignments
                for index in 0...arrJSON.count-1 {
                    let aObject = arrJSON.objectAt(index) as! [String : AnyObject]
                    //If the subject is selected by the user and he/she has not completed the assignment, it should be added.
                    if(ChooseSubject.mySubjectCodes.contains(aObject["subject"] as! String) && !(FirstOpen.completedAssignments.contains(aObject["id"] as! String))){
                        ids.append(aObject["id"] as! String)
                        names.append(aObject["name"] as! String)
                        subjects.append(aObject["subject"] as! String)
                        descriptions.append(aObject["description"] as! String)
                        deadlines.append(aObject["deadline"] as! String)
                    }
                }
            }
            //Reload the table with the new information
            self.tabell.reloadData()
        }
        catch {
            
        }
        //Hides the table if assignments are equal to 0
        if (ChooseSubject.mySubjects.count == 0){
            tabell.isHidden = true
        }
    }
    
    //Runs when a user completes an assignment. Saves the data for later use.
    static func completeAssignment(){
        UserDefaults.standard.set(FirstOpen.completedAssignments, forKey: "Nøkkel")
        UserDefaults.standard.set(true, forKey: "launchedBefore2")
    }
    
    //Standard function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Returns the number of assignments
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count;
    }
    
    //Iterates through the assignments and adds the correct data to each cell
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
    
    //When an assignment is completed, it is added to the completed assignments and removed from the table
    func tableView(_ tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let complete = UITableViewRowAction(style: .normal, title: "Complete") { action, index in
            FirstOpen.completedAssignments.append(self.ids[indexPath.row]+"")
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
