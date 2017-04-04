//
//  ChooseSubject.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 19.02.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class ChooseSubject: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //Defines variables
    
    @IBOutlet weak var subjectTable: UITableView!
    @IBOutlet weak var resetButton: UIButton!
    static var mySubjects = [String]()
    static var mySubjectCodes = [String]()
    
    //This method is called when the reset assignments-button is pushed. It displays an alert where the user has to confirm
    //they really want to reset the completed assignments, or cancel.
    @IBAction func resetCompletedAssigments(_ sender: Any) {
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to reset your completed assignments? All data will be lost", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Cancel", style: UIAlertActionStyle.cancel, handler:{(action) in alert.dismiss(animated:true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title:"Reset", style: UIAlertActionStyle.destructive, handler:{(action) in alert.dismiss(animated:true, completion: nil)
            //The completed assignments-array is set to an empty one.
            FirstOpen.completedAssignments = [String]()
            //Saves the array
            FirstOpen.completeAssignment()
            self.resetButton.isHidden = true
        }))
        self.present(alert, animated:true, completion: nil)
    }
    
    //viewDidLoad is called every time the user opens this view. The reset button should not be visible if the user has not
    //completed any assignments. If this is the first time the user opens the view for this session, the assignments-list
    //will be updated from the database.
    override func viewDidLoad() {
        super.viewDidLoad()
        if(FirstOpen.completedAssignments.count==0){
            resetButton.isHidden = true
        }
        if(constants.firstOpenDuringSession){
            //Refreshes the assignments from the DB if this is the first time opening the view during this session.
            refreshAssignments()
        }
    }
    
    //Get the assignments from the DB.
    func refreshAssignments(){
        constants.firstOpenDuringSession = false
        let url=URL(string:"http://folk.ntnu.no/sondrbre/getSubjects.php")
        do {
            let allAssignmentsData = try Data(contentsOf: url!)
            let allAssignments = try JSONSerialization.jsonObject(with: allAssignmentsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            if let arrJSON = allAssignments["subjects"]{
                for index in 0...arrJSON.count-1 {
                    let aObject = arrJSON.objectAt(index) as! [String : AnyObject]
                    constants.allAssignmentsSubjectCodes.append(aObject["subject_code"] as! String)
                    constants.allAssignmentsSubjects.append(aObject["subject_name"] as! String)
                }
            }
            //Reloads the data on the table
            self.subjectTable.reloadData()
        }
        catch {
        }
    }
    
    //Saves the selected subjects to the iOS device so it's available the next time the user opens the app.
    static func saveForOffline(){
        UserDefaults.standard.set(mySubjects, forKey: "mySubjects")
        UserDefaults.standard.set(true, forKey: "launchedBefore")
    }
    
    //Standard method, not really used
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Returns the number of subjects available to the user for the table.
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (constants.allAssignmentsSubjects.count)
    }
    
    //Feeds the cells with the information needed, and adds this to each cell.
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.content.text = constants.allAssignmentsSubjectCodes[indexPath.row] + " - " + constants.allAssignmentsSubjects[indexPath.row]
        //Creates a tag on each row so it can easily be indentified when a button is clicked.
        cell.content.tag = indexPath.row
        //The button is 'on' if the subjects is already contained in mySubjects.
        if(!ChooseSubject.mySubjects.contains(cell.content.text!)){
            cell.svitsj.setOn(false, animated: false)
        }
        else{
            cell.svitsj.setOn(true, animated: false)
        }
        return cell
    }
}
