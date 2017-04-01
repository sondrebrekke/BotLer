//
//  FeedbackClass.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 06.02.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class FeedbackClass: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate{

    @IBOutlet weak var yesBtnL: UIButton!
    @IBOutlet weak var noBtnL: UIButton!
    @IBOutlet weak var tsBtnP: UIButton!
    @IBOutlet weak var jrBtnP: UIButton!
    @IBOutlet weak var tfBtnP: UIButton!
    @IBOutlet weak var insertFeedback: UITextField!

    @IBOutlet weak var velgFagKnapp: UIButton!
    @IBOutlet weak var attend: UITextView!
    @IBOutlet weak var attendText: UITextView!
    @IBOutlet weak var notAttendText: UITextView!
    @IBOutlet weak var recapText: UITextView!
    @IBOutlet weak var paceText: UITextView!
    @IBOutlet weak var submit: UIButton!
    
    static var attended:String = ""
    static var feedback:String = ""
    static var pace:String = ""
    static var valgtFag:String = ""
    var fag:[String] = []
    var subject = ""
    static var subjectName = ""


    
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var selectedSubject: UITextField!
    
    func textFieldShouldReturn(_ insertFeedback: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        if (yesBtnL.backgroundColor == UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)){
            FeedbackClass.attended = "YES"
        }
        else{
            FeedbackClass.attended = "NO"
        }
        FeedbackClass.feedback = insertFeedback.text!
        if (tsBtnP.backgroundColor == UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)){
            FeedbackClass.pace = "TOO SLOW"
        }
        else if (jrBtnP.backgroundColor == UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)){
            FeedbackClass.pace = "JUST RIGHT"
        }
        else{
            FeedbackClass.pace = "TOO FAST"
        }
        if(FeedbackClass.attended == "NO"){
            FeedbackClass.pace = ""
        }
        
        let url = NSURL(string: "http://folk.ntnu.no/sondrbre/receive.php")
        
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        
        var dataString = "secretWord=44fdcv8jf3" // starting POST string with a secretWord
        
        dataString = dataString + "&attended=\(FeedbackClass.attended)"
        dataString = dataString + "&feedback=\(FeedbackClass.feedback)"
        dataString = dataString + "&pace=\(FeedbackClass.pace)"
        dataString = dataString + "&subject=\(subject)"
        
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
    
    @IBAction func yesBtnLClicked(_ sender: Any) {
        noBtnL.isSelected = false
        noBtnL.backgroundColor = UIColor.white
        noBtnL.setTitleColor(UIColor.gray, for: .normal)
        if(yesBtnL.isSelected == false && (tsBtnP.isSelected == true || jrBtnP.isSelected == true || tfBtnP.isSelected == true)){
            yesBtnL.isSelected = true
            yesBtnL.backgroundColor = UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)
            yesBtnL.setTitleColor(UIColor.white, for: .normal)
            tsBtnP.isHidden = false
            jrBtnP.isHidden = false
            tfBtnP.isHidden = false
            paceText.isHidden = false
            notAttendText.isHidden = true
            recapText.isHidden = false
            insertFeedback.isHidden = false
            submit.isHidden = false
        }
        
        else if (yesBtnL.backgroundColor == UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)){
            yesBtnL.isSelected = false
            yesBtnL.backgroundColor = UIColor.white
            yesBtnL.setTitleColor(UIColor.gray, for: .normal)
            tsBtnP.isHidden = true
            jrBtnP.isHidden = true
            tfBtnP.isHidden = true
            paceText.isHidden = true
            recapText.isHidden = true
            insertFeedback.isHidden = true
            submit.isHidden = true

        }
        else{
            yesBtnL.isSelected = true
            yesBtnL.backgroundColor = UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)
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
        yesBtnL.isSelected = false
        yesBtnL.backgroundColor = UIColor.white
        yesBtnL.setTitleColor(UIColor.gray, for: .normal)
        if (noBtnL.backgroundColor == UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)){
            noBtnL.isSelected = false
            noBtnL.backgroundColor = UIColor.white
            noBtnL.setTitleColor(UIColor.gray, for: .normal)
            submit.isHidden = true
            notAttendText.isHidden = true
            insertFeedback.isHidden = true
        }
        else{
            noBtnL.isSelected = true
            noBtnL.backgroundColor = UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)
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
        jrBtnP.isSelected = false
        tfBtnP.isSelected = false
        jrBtnP.backgroundColor = UIColor.white
        tfBtnP.backgroundColor = UIColor.white
        jrBtnP.setTitleColor(UIColor.gray, for: .normal)
        tfBtnP.setTitleColor(UIColor.gray, for: .normal)
        if (tsBtnP.backgroundColor == UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)){
            tsBtnP.isSelected = false
            tsBtnP.backgroundColor = UIColor.white
            tsBtnP.setTitleColor(UIColor.gray, for: .normal)
            submit.isHidden = true
        }
        else{
            tsBtnP.isSelected = true
            tsBtnP.backgroundColor = UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)
            tsBtnP.setTitleColor(UIColor.white, for: .normal)
            submit.isHidden = false
        }
    }
    
    @IBAction func jrBtnPClicked(_ sender: Any) {
        tfBtnP.isSelected = false
        tsBtnP.isSelected = false
        tsBtnP.backgroundColor = UIColor.white
        tfBtnP.backgroundColor = UIColor.white
        tsBtnP.setTitleColor(UIColor.gray, for: .normal)
        tfBtnP.setTitleColor(UIColor.gray, for: .normal)
        
        if (jrBtnP.backgroundColor == UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)){
            jrBtnP.isSelected = false
            jrBtnP.backgroundColor = UIColor.white
            jrBtnP.setTitleColor(UIColor.gray, for: .normal)
            submit.isHidden = true
        }
        else{
            jrBtnP.isSelected = true
            jrBtnP.backgroundColor = UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)
            jrBtnP.setTitleColor(UIColor.white, for: .normal)
            submit.isHidden = false
        }
    }

    @IBAction func tfBtnPClicked(_ sender: Any) {
        jrBtnP.isSelected = false
        tsBtnP.isSelected = false
        jrBtnP.backgroundColor = UIColor.white
        tsBtnP.backgroundColor = UIColor.white
        jrBtnP.setTitleColor(UIColor.gray, for: .normal)
        tsBtnP.setTitleColor(UIColor.gray, for: .normal)
        if (tfBtnP.backgroundColor == UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)){
            tfBtnP.isSelected = false
            tfBtnP.backgroundColor = UIColor.white
            tfBtnP.setTitleColor(UIColor.gray, for: .normal)
            submit.isHidden = true
        }
        else{
            tfBtnP.isSelected = true
            tfBtnP.backgroundColor = UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)
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
        attend.isHidden = true
        attendText.isHidden = true
        notAttendText.isHidden = true
        recapText.isHidden = true
        insertFeedback.isHidden = true
        submit.isHidden = true
        yesBtnL.isHidden = true
        noBtnL.isHidden = true
        tsBtnP.isSelected = false
        jrBtnP.isSelected = false
        tfBtnP.isSelected = false
        submit.isSelected = false
        yesBtnL.isSelected = false
        noBtnL.isSelected = false
        fag.append("Click here to choose a subject")
        fag += ChooseSubject.mineFag
        self.selectedSubject.text? = fag[0]
        self.dropDown.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return fag.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return fag[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(fag[row] != "Click here to choose a subject"){
            self.selectedSubject.text? = fag[row]
            subject = fag[row].components(separatedBy: " ")[0]
            FeedbackClass.subjectName = fag[row]
            attendText.isHidden = false
            attend.isHidden = false
            yesBtnL.isHidden = false
            noBtnL.isHidden = false
            
        }
        else{
            self.selectedSubject.text? = fag[row]
            attendText.isHidden = true
            attend.isHidden = true
            yesBtnL.isHidden = true
            noBtnL.isHidden = true
            
        }
        self.dropDown.isHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.selectedSubject {
            self.dropDown.isHidden = false
            attend.isHidden = true
            yesBtnL.isHidden = true
            noBtnL.isHidden = true
            tsBtnP.isHidden = true
            jrBtnP.isHidden = true
            tfBtnP.isHidden = true
            notAttendText.isHidden = true
            recapText.isHidden = true
            insertFeedback.isHidden = true
            submit.isHidden = true
            paceText.isHidden = true
            yesBtnL.isSelected = false
            noBtnL.isSelected = false
            tsBtnP.isSelected = false
            jrBtnP.isSelected = false
            tfBtnP.isSelected = false
            yesBtnL.backgroundColor = UIColor.white
            yesBtnL.setTitleColor(UIColor.gray, for: .normal)
            noBtnL.backgroundColor = UIColor.white
            noBtnL.setTitleColor(UIColor.gray, for: .normal)
            tsBtnP.backgroundColor = UIColor.white
            tsBtnP.setTitleColor(UIColor.gray, for: .normal)
            jrBtnP.backgroundColor = UIColor.white
            jrBtnP.setTitleColor(UIColor.gray, for: .normal)
            tfBtnP.backgroundColor = UIColor.white
            tfBtnP.setTitleColor(UIColor.gray, for: .normal)
            textField.endEditing(true)
        }
    }

}
