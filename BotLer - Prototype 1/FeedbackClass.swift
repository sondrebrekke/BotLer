//
//  FeedbackClass.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 06.02.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class FeedbackClass: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var yesBtnL: UIButton!
    @IBOutlet weak var noBtnL: UIButton!
    @IBOutlet weak var tsBtnP: UIButton!
    @IBOutlet weak var jrBtnP: UIButton!
    @IBOutlet weak var tfBtnP: UIButton!
    @IBOutlet weak var insertFeedback: UITextField!

    @IBOutlet weak var attendText: UITextView!
    @IBOutlet weak var notAttendText: UITextView!
    @IBOutlet weak var recapText: UITextView!
    @IBOutlet weak var paceText: UITextView!
    @IBOutlet weak var submit: UIButton!
    
    func textFieldShouldReturn(_ insertFeedback: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func yesBtnLClicked(_ sender: Any) {
        noBtnL.backgroundColor = UIColor.white
        noBtnL.setTitleColor(UIColor.gray, for: .normal)
        if (yesBtnL.backgroundColor == UIColor(red:0.00, green:0.40, blue:1.00, alpha:1.0)){
            yesBtnL.backgroundColor = UIColor.white
            yesBtnL.setTitleColor(UIColor.gray, for: .normal)
            submit.isHidden = true
            tsBtnP.isHidden = true
            jrBtnP.isHidden = true
            tfBtnP.isHidden = true
            paceText.isHidden = true
            recapText.isHidden = true
            insertFeedback.isHidden = true

        }
        else{
            yesBtnL.backgroundColor = UIColor(red:0.00, green:0.40, blue:1.00, alpha:1.0)
            yesBtnL.setTitleColor(UIColor.white, for: .normal)
            tsBtnP.isHidden = false
            jrBtnP.isHidden = false
            tfBtnP.isHidden = false
            paceText.isHidden = false
            notAttendText.isHidden = true
            recapText.isHidden = false
            insertFeedback.isHidden = false
            submit.isHidden = true
        }
        
    }
    
    @IBAction func noBtnLClicked(_ sender: Any) {
        yesBtnL.backgroundColor = UIColor.white
        yesBtnL.setTitleColor(UIColor.gray, for: .normal)
        if (noBtnL.backgroundColor == UIColor(red:0.00, green:0.40, blue:1.00, alpha:1.0)){
            noBtnL.backgroundColor = UIColor.white
            noBtnL.setTitleColor(UIColor.gray, for: .normal)
            submit.isHidden = true
        }
        else{
            noBtnL.backgroundColor = UIColor(red:0.00, green:0.40, blue:1.00, alpha:1.0)
            noBtnL.setTitleColor(UIColor.white, for: .normal)
            
            tsBtnP.isHidden = true
            jrBtnP.isHidden = true
            tfBtnP.isHidden = true
            paceText.isHidden = true
            notAttendText.isHidden = false
            recapText.isHidden = true
            insertFeedback.isHidden = false
            submit.isHidden = false
        }
    }

    @IBAction func tsBtnPClicked(_ sender: Any) {
        jrBtnP.backgroundColor = UIColor.white
        tfBtnP.backgroundColor = UIColor.white
        jrBtnP.setTitleColor(UIColor.gray, for: .normal)
        tfBtnP.setTitleColor(UIColor.gray, for: .normal)
        if (tsBtnP.backgroundColor == UIColor(red:0.00, green:0.40, blue:1.00, alpha:1.0)){
            tsBtnP.backgroundColor = UIColor.white
            tsBtnP.setTitleColor(UIColor.gray, for: .normal)
            submit.isHidden = true
        }
        else{
            tsBtnP.backgroundColor = UIColor(red:0.00, green:0.40, blue:1.00, alpha:1.0)
            tsBtnP.setTitleColor(UIColor.white, for: .normal)
            submit.isHidden = false
        }
    }
    
    @IBAction func jrBtnPClicked(_ sender: Any) {
        tsBtnP.backgroundColor = UIColor.white
        tfBtnP.backgroundColor = UIColor.white
        tsBtnP.setTitleColor(UIColor.gray, for: .normal)
        tfBtnP.setTitleColor(UIColor.gray, for: .normal)
        
        if (jrBtnP.backgroundColor == UIColor(red:0.00, green:0.40, blue:1.00, alpha:1.0)){
            jrBtnP.backgroundColor = UIColor.white
            jrBtnP.setTitleColor(UIColor.gray, for: .normal)
            submit.isHidden = true
        }
        else{
            jrBtnP.backgroundColor = UIColor(red:0.00, green:0.40, blue:1.00, alpha:1.0)
            jrBtnP.setTitleColor(UIColor.white, for: .normal)
            submit.isHidden = false
        }
    }

    @IBAction func tfBtnPClicked(_ sender: Any) {
        jrBtnP.backgroundColor = UIColor.white
        tsBtnP.backgroundColor = UIColor.white
        jrBtnP.setTitleColor(UIColor.gray, for: .normal)
        tsBtnP.setTitleColor(UIColor.gray, for: .normal)
        if (tfBtnP.backgroundColor == UIColor(red:0.00, green:0.40, blue:1.00, alpha:1.0)){
            tfBtnP.backgroundColor = UIColor.white
            tfBtnP.setTitleColor(UIColor.gray, for: .normal)
            submit.isHidden = true
        }
        else{
            tfBtnP.backgroundColor = UIColor(red:0.00, green:0.40, blue:1.00, alpha:1.0)
            tfBtnP.setTitleColor(UIColor.white, for: .normal)
            submit.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.insertFeedback.delegate = self;
        
        tsBtnP.isHidden = true
        jrBtnP.isHidden = true
        tfBtnP.isHidden = true
        paceText.isHidden = true
        notAttendText.isHidden = true
        recapText.isHidden = true
        insertFeedback.isHidden = true
        submit.isHidden = true
        yesBtnL.isHidden = false
        noBtnL.isHidden = false
        attendText.isHidden = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
