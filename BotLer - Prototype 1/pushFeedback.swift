//
//  pushFeedback.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 08.03.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class pushFeedback: UIViewController {

    @IBOutlet weak var textField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = "Your response was sendt to the lecturer of " + FeedbackClass.subjectName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
