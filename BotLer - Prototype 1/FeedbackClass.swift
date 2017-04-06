//
//  FeedbackClass.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 06.02.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class FeedbackClass: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate{

    //References to buttons, L is short for Lecture and P is short for Pace
    @IBOutlet weak var yesBtnL: UIButton!
    @IBOutlet weak var noBtnL: UIButton!
    @IBOutlet weak var tsBtnP: UIButton!
    @IBOutlet weak var jrBtnP: UIButton!
    @IBOutlet weak var tfBtnP: UIButton!
    @IBOutlet weak var submit: UIButton!
    
    //References to the textfields and textviews
    @IBOutlet weak var insertFeedback: UITextField!
    @IBOutlet weak var attend: UITextView!
    @IBOutlet weak var attendText: UITextView!
    @IBOutlet weak var notAttendText: UITextView!
    @IBOutlet weak var recapText: UITextView!
    @IBOutlet weak var paceText: UITextView!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var selectedSubject: UITextField!

    //Declaring varibles for later use
    static var attended:String = ""
    static var feedback:String = ""
    static var pace:String = ""
    var subjects:[String] = []
    var subject = ""
    static var subjectName = ""

    //Ends the editing when a user has selected a subject
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //This method is called when the 'submit'-button is clicked.
    @IBAction func submitClicked(_ sender: Any) {
        //If the backgroundcolor of the yes-button is blue, it's selected and the Feedback text should be YES. 
        //Otherwise, it should be NO
        if (yesBtnL.backgroundColor == UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)){
            FeedbackClass.attended = "YES"
        }
        else{
            FeedbackClass.attended = "NO"
        }
        
        //The feedbacktext the user has written is inserted in to a variable
        FeedbackClass.feedback = insertFeedback.text!
        
        //Checks the pace the user has selected.
        if (tsBtnP.backgroundColor == UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)){
            FeedbackClass.pace = "TOO SLOW"
        }
        else if (jrBtnP.backgroundColor == UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)){
            FeedbackClass.pace = "JUST RIGHT"
        }
        else if (tfBtnP.backgroundColor == UIColor(red: 35/255, green: 132/255, blue: 247/255, alpha: 1)){
            FeedbackClass.pace = "TOO FAST"
        }
        
        //Defines the url where the Query for inserting the feedback is located
        let url = NSURL(string: "http://folk.ntnu.no/sondrbre/receive.php")
        
        //Opens a request which will post to the DB
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        
        //Starting post string with a secret word to make sure no others can provide feedback
        var dataString = "secretWord=44fdcv8jf3"
        
        //Adds the feedback to the datastring
        dataString = dataString + "&attended=\(FeedbackClass.attended)"
        dataString = dataString + "&feedback=\(FeedbackClass.feedback)"
        dataString = dataString + "&pace=\(FeedbackClass.pace)"
        dataString = dataString + "&subject=\(subject)"
        
        // convert to utf8 string
        let dataD = dataString.data(using: .utf8)
        
        do
        {
            //Uploads
            let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD)
            {
                data, response, error in
                
                if error != nil {
                    
                    //Displays an alert if the data could not be updated
                    DispatchQueue.main.async
                        {
                            let alert = UIAlertController(title: "Upload failed.", message: "Looks like the connection to the server didn't work. Please check your internet access and try again.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                    }
                }
                else
                {
                    if let unwrappedData = data {
                        // Response from web server hosting the database
                        let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        if returnedData == "1" // insert into database worked, returns 1 from php-file
                        {
                            
                            // display an alert if no error and database insert worked (return = 1) inside the DispatchQueue.main.async
                            
                            DispatchQueue.main.async
                                {
                                    let alert = UIAlertController(title: "Success!", message: "The feedback was sent to the lecturer of " + FeedbackClass.subjectName + ".", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                        self.resetDisplay()
                                    self.present(alert, animated: true, completion: nil)

                            }
                        }
                        else
                        {
                            // display an alert if an error and database insert didn't worked (return != 1) inside the DispatchQueue.main.async
                            
                            DispatchQueue.main.async
                                {
                                    
                                    let alert = UIAlertController(title: "Upload failed", message: "Could not provide the feedback to the lecturer. Please send an email to botler@gmail.com", preferredStyle: .alert)
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
    
    //This functions hides the buttons and set the selector at the default option.
    func resetDisplay(){
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
        self.selectedSubject.text? = subjects[0]
        self.dropDown.isHidden = true
        insertFeedback.text? = ""
        dropDown.selectRow(0, inComponent: 0, animated: true)
    }
    
    //Runs when yes-button is clicked
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
    
    //Runs when no-button is clicked
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

    //Runs when tooslow-button is clicked
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
    
    //Runs when justright-button is clicked
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

    //Runs when toofast-button is clicked
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
    
    //Runs when the view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        subjects.append("Click here to choose a subject")
        subjects += ChooseSubject.mySubjects
        insertFeedback.delegate = self
        resetDisplay()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FeedbackClass.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    //This functions dissmisses the user keyboard when the user presses anywhere but the text field.
    func dismissKeyboard() {
        view.endEditing(true)
    }

    //Standard method
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    //Returns the number of subjects available to pick.
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return subjects.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return subjects[row]
        
    }
    
    //This function is ran when the user selects a subject from the roll-down menu.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(subjects[row] != "Click here to choose a subject"){
            self.selectedSubject.text? = subjects[row]
            subject = subjects[row].components(separatedBy: " ")[0]
            FeedbackClass.subjectName = subjects[row]
            attendText.isHidden = false
            attend.isHidden = false
            yesBtnL.isHidden = false
            noBtnL.isHidden = false
            
        }
        else{
            self.selectedSubject.text? = subjects[row]
            attendText.isHidden = true
            attend.isHidden = true
            yesBtnL.isHidden = true
            noBtnL.isHidden = true
            
        }
        self.dropDown.isHidden = true
    }
    
    //The function is ran when the user clicks the 'choose subject'-button.
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
