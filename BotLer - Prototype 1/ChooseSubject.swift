//
//  ChooseSubject.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 19.02.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class ChooseSubject: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tabell: UITableView!
    static var mineFag = [String]()
    static var mineFagKoder = [String]()
    let textCellIdentifier = "ShowCell"
    @IBOutlet weak var resetButton: UIButton!
    
    var blogName = String()

    @IBAction func resetCompletedAssigments(_ sender: Any) {
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to reset your completed assignments? All data will be lost", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Cancel", style: UIAlertActionStyle.cancel, handler:{(action) in alert.dismiss(animated:true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title:"Reset", style: UIAlertActionStyle.destructive, handler:{(action) in alert.dismiss(animated:true, completion: nil)
            FirstOpen.completedAssignments = [String]()
            FirstOpen.completeAssignment()
            self.resetButton.isHidden = true
        }))
        self.present(alert, animated:true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(FirstOpen.completedAssignments.count==0){
            resetButton.isHidden = true
        }
        if(constants.firstOpen){
            showAssignments()
        }
    }


    func showAssignments(){
        constants.firstOpen = false
        let url=URL(string:"http://folk.ntnu.no/sondrbre/getSubjects.php")
        do {
            let allContactsData = try Data(contentsOf: url!)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            if let arrJSON = allContacts["subjects"]{
                for index in 0...arrJSON.count-1 {
                    let aObject = arrJSON.objectAt(index) as! [String : AnyObject]
                    constants.fagKode.append(aObject["subject_code"] as! String)
                    constants.fag.append(aObject["subject_name"] as! String)
                }
            }
            
            self.tabell.reloadData()
        }
        catch {
        }
        resetButton.layer.cornerRadius = 12
    }
    
    static func lagre(){
        UserDefaults.standard.set(mineFag, forKey: "Key")
        UserDefaults.standard.set(true, forKey: "launchedBefore")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (constants.fag.count)
    }

    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.content.text = constants.fagKode[indexPath.row] + " - " + constants.fag[indexPath.row]
        cell.content.tag = indexPath.row
        if(!ChooseSubject.mineFag.contains(cell.content.text!)){
            cell.svitsj.setOn(false, animated: false)
        }
        else{
            cell.svitsj.setOn(true, animated: false)

        }
        return cell
    }
}
