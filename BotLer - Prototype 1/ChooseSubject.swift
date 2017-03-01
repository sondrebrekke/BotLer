//
//  ChooseSubject.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 19.02.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit
import Kanna
import Alamofire

class ChooseSubject: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tabell: UITableView!
    static var mineFag = [String]()
    var fag = [String]()
    let textCellIdentifier = "ShowCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrapeFag()
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            ChooseSubject.mineFag = UserDefaults.standard.array(forKey: "Key") as! [String]
        }

        // Do any additional setup after loading the view.
    }
    
    func scrapeFag() -> Void {
        Alamofire.request("http://folk.ntnu.no/marentno/fag.html").responseString { response in
            if let html = response.result.value {
                self.parseHTML(html: html)
            }
        }
    }
    
    
    func parseHTML(html: String) -> Void {
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            
            // Search for nodes by CSS selector
            for show in doc.css("p") {
                
                // Strip the string of surrounding whitespace.
                let showString = show.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                // Alle fag starter med fagkode
                let regex = try! NSRegularExpression(pattern: "^()", options: [.caseInsensitive])
                
                if regex.firstMatch(in: showString, options: [], range: NSMakeRange(0, showString.characters.count)) != nil {
                    fag.append(showString)
                }
            }
        }
        self.tabell.reloadData()
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
        cell.content.text = fag[indexPath.row]
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
