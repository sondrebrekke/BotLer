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

    @IBOutlet weak var ikkeValgtFag: UITextView!
    @IBOutlet weak var velgFagKnapp: UIButton!
    @IBOutlet weak var attend: UITextView!
    @IBOutlet weak var errorField: UITextView!
    @IBOutlet weak var attendText: UITextView!
    @IBOutlet weak var notAttendText: UITextView!
    @IBOutlet weak var recapText: UITextView!
    @IBOutlet weak var paceText: UITextView!
    @IBOutlet weak var submit: UIButton!
    
    static var attended:String = ""
    static var feedback:String = ""
    static var pace:String = ""
    static var valgtFag:String = ""
    
    func textFieldShouldReturn(_ insertFeedback: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        if (yesBtnL.backgroundColor == UIColor(red:0.00, green:0.40, blue:1.00, alpha:1.0)){
            FeedbackClass.attended = "YES"
        }
        else{
            FeedbackClass.attended = "NO"
        }
        FeedbackClass.feedback = insertFeedback.text!
        if (tsBtnP.backgroundColor == UIColor(red:0.00, green:0.40, blue:1.00, alpha:1.0)){
            FeedbackClass.pace = "TOO SLOW"
        }
        else if (jrBtnP.backgroundColor == UIColor(red:0.00, green:0.40, blue:1.00, alpha:1.0)){
            FeedbackClass.pace = "JUST RIGHT"
        }
        else{
            FeedbackClass.pace = "TOO FAST"
        }
        if(FeedbackClass.attended == "NO"){
            FeedbackClass.pace = ""
        }
        
        let url = NSURL(string: "http://folk.ntnu.no/sondrbre/receive.php")
        
        var request = URLRequest(url: url as! URL)
        request.httpMethod = "POST"
        
        var dataString = "secretWord=44fdcv8jf3" // starting POST string with a secretWord
        
        dataString = dataString + "&attended=\(FeedbackClass.attended)"
        dataString = dataString + "&feedback=\(FeedbackClass.feedback)"
        dataString = dataString + "&pace=\(FeedbackClass.pace)"
        dataString = dataString + "&subject=\(SubjectFeedback.valgtFag.components(separatedBy: " ")[0])"
    
        
        let dataD = dataString.data(using: .utf8) // convert to utf8 string
        
        do
        {
            
            // the upload task, uploadJob, is defined here
            
            let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD)
            {
                data, response, error in
                
                if error != nil {
                    
                    // display an alert if there is an error inside the DispatchQueue.main.async
                    
                    DispatchQueue.main.async
                        {
                            let alert = UIAlertController(title: "Upload Didn't Work?", message: "Looks like the connection to the server didn't work.  Do you have Internet access?", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                    }
                }
                else
                {
                    if let unwrappedData = data {
                        
                        let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) // Response from web server hosting the database
                        
                        if returnedData == "1" // insert into database worked
                        {
                            
                            // display an alert if no error and database insert worked (return = 1) inside the DispatchQueue.main.async
                            
                            DispatchQueue.main.async
                                {
                                    let alert = UIAlertController(title: "Upload OK?", message: "Looks like the upload and insert into the database worked.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            // display an alert if an error and database insert didn't worked (return != 1) inside the DispatchQueue.main.async
                            
                            DispatchQueue.main.async
                                {
                                    
                                    let alert = UIAlertController(title: "Upload Didn't Work", message: "Looks like the insert into the database did not worked.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
            uploadJob.resume()
        }
    }
    
    @IBAction func velgFag(_ sender: Any) {
        errorField.isHidden = true
        attendText.isHidden = false
        attend.isHidden = false
        yesBtnL.isHidden = false
        noBtnL.isHidden = false
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
        if(ChooseSubject.mineFag.count < 1){
            velgFagKnapp.isHidden = true
            ikkeValgtFag.isHidden = false
        }
        else{
            ikkeValgtFag.isHidden = true
        }
        errorField.isHidden = false
        tsBtnP.isHidden = true
        jrBtnP.isHidden = true
        tfBtnP.isHidden = true
        paceText.isHidden = true
        attend.isHidden = true
        attendText.isHidden = true
        notAttendText.isHidden = true
        recapText.isHidden = true
        insertFeedback.isHidden = true
        submit.isHidden = true
        yesBtnL.isHidden = true
        noBtnL.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
