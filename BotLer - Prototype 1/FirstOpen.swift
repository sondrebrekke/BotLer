//
//  FirstOpen.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 01.03.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class FirstOpen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            ChooseSubject.mineFag = UserDefaults.standard.array(forKey: "Key") as! [String]
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
