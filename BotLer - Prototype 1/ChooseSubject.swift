//
//  ChooseSubject.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 19.02.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit
//import Kanna
//import Alamofire

class ChooseSubject: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tabell: UITableView!
    static var mineFag = [String]()
    static var mineFagKoder = [String]()
    var fagKode = [String]()
    var fag = [String]()
    let textCellIdentifier = "ShowCell"
    @IBOutlet weak var resetButton: UIButton!
    
    var blogName = String()
    
    override func viewWillAppear(_ animated: Bool) {
        if(FirstOpen.completedAssignments.count==0){
            resetButton.isHidden = true
        }
    }
    
    @IBAction func resetCompletedAssigments(_ sender: Any) {
        FirstOpen.completedAssignments = [String]()
        FirstOpen.completeAssignment()
        resetButton.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url=URL(string:"http://folk.ntnu.no/sondrbre/getSubjects.php")
        do {
            let allContactsData = try Data(contentsOf: url!)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            if let arrJSON = allContacts["subjects"]{
                for index in 0...arrJSON.count-1 {
                    
                    let aObject = arrJSON.objectAt(index) as! [String : AnyObject]
                    fagKode.append(aObject["subject_code"] as! String)
                    fag.append(aObject["subject_name"] as! String)
                }
            }
            
            self.tabell.reloadData()
        }
        catch {
            
        }

    }


    
    static func lagre(){
        UserDefaults.standard.set(mineFag, forKey: "Key")
        UserDefaults.standard.set(true, forKey: "launchedBefore")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (fag.count)
    }

    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.content.text = fagKode[indexPath.row] + " - " + fag[indexPath.row]
        cell.content.tag = indexPath.row
        if(!ChooseSubject.mineFag.contains(cell.content.text!)){
            cell.svitsj.setOn(false, animated: false)
        }
        else{
            cell.svitsj.setOn(true, animated: false)

        }
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
