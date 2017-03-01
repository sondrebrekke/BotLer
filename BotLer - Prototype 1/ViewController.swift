//
//  ViewController.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 05.02.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let fysikkØving = ["Øving 1","Øving 2","Øving 3","Øving 4"]
    let matteØving = ["Øving 1","Øving 2","Øving 3","Øving 4"]
    var rader = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (4)
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = fysikkØving[indexPath.row]
        return cell
    }




}

