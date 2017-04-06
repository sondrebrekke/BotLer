//
//  Statistics.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 28.03.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class Statistics: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {

    //Defining variables for later use
    var ids: [String] = []
    var names: [String] = []
    var Comids: [String] = []
    var Comnames: [String] = []
    var subject = ""
    var antall = 0
    var fag:[String] = []
    
    //Links to buttons and textviews.
    @IBOutlet weak var selectedSubject: UITextView!
    @IBOutlet weak var assignmentsText: UITextView!
    @IBOutlet weak var prosentText: UITextView!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var nrOfSubjects: UITextView!
    @IBOutlet weak var completed: UITextView!
    
    //This function runs when the selected view is opened. It hides the completion-text until a subject is selected.
    override func viewDidLoad() {
        super.viewDidLoad()
        prosentText.isHidden = true
        assignmentsText.isHidden = true
        nrOfSubjects.delegate  = self
        completed.delegate  = self
        fag.append("Click here to choose a subject")
        fag += ChooseSubject.mySubjects
        self.textBox.text? = fag[0]
        self.dropDown.isHidden = true
    }
    
    //runs every time a user access the 'statistics'-page, not neccesary when the view is loaded.
    override func viewDidAppear(_ animated: Bool){
        prosentText.isHidden = true
        assignmentsText.isHidden = true
        nrOfSubjects.delegate  = self
        completed.delegate  = self
        fag.append("Click here to choose a subject")
        fag += ChooseSubject.mySubjects
        self.textBox.text? = fag[0]
        self.dropDown.isHidden = true
        nrOfSubjects.text? = ""
        completed.text? = ""
        prosentText.text? = ""
        dropDown.selectRow(0, inComponent: 0, animated: true)
    }
    
    //Gets the subjects and count number of completed assignments.
    func printFag(){
        ids = []
        names = []
        Comids = []
        Comnames = []
        antall = 0
        
        //This is the url where the data is collected from
        let url=URL(string:"http://folk.ntnu.no/sondrbre/index.php")
        do {
            let allAssignmentsData = try Data(contentsOf: url!)
            let allAssignments = try JSONSerialization.jsonObject(with: allAssignmentsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            if let arrJSON = allAssignments["data"]{
                for index in 0...arrJSON.count-1 {
                    let aObject = arrJSON.objectAt(index) as! [String : AnyObject]
                    //If the subject is the selected subject, it will add the assignments and count number of completed.
                    if(aObject["subject"] as! String == subject){
                        ids.append(aObject["id"] as! String)
                        if(FirstOpen.completedAssignments.contains(aObject["id"] as! String)){
                            antall = antall + 1
                            Comids.append(aObject["id"] as! String)
                            Comnames.append(aObject["name"] as! String)
                        }
                        names.append(aObject["name"] as! String)
                    }
                }
            }
        }
        catch {
            
        }
        var streng:String = ""
        var streng2:String = ""
        if(ids.count != 0){
            //Calculates the completage percentage
            let prosent:Double = round(10*(Double(Comids.count))/(Double(ids.count))*100)/10
            prosentText.text? = String(prosent) + "%"
            var ant = 0
            //Uses HTML coding to differ text color between completed and not completed.
            streng += "<p style=\"line-height:1.7\">"
            streng2 += "<p style=\"line-height:1.7\" align=\'right\'>"
            for index in 0...ids.count-1 {
                if(!Comids.contains(ids[index])){
                    streng += "<font color=\"#666666\" face=\"Arial\" size=\"4.8\">\(names[index]):</font><br>"
                    streng2 += "<font color=\"red\" face=\"Arial\" size=\"4.8\">Not completed</font><br>"
                }
                else{
                    streng += "<font color=\"#666666\" face=\"Arial\" size=\"4.8\">\(Comnames[ant]):</font><br>"
                    streng2 += "<font color=\"#00ba00\" face=\"Arial\" size=\"4.8\">Completed</font><br>"
                    ant += 1
                }
            }
            streng += "</p>"
            streng2 += "</p>"

            let encodedData = streng2.data(using: String.Encoding.utf8)!
            let encodedData2 = streng.data(using: String.Encoding.utf8)!
            let attributedOptions = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
            do {
                let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
                completed.attributedText? = attributedString
                let attributedString2 = try NSAttributedString(data: encodedData2, options: attributedOptions, documentAttributes: nil)
                nrOfSubjects.attributedText? = attributedString2

            } catch _ {
                print("Cannot create attributed String")
            }
        }
        else{
            nrOfSubjects.text? = ""
            completed.text? = ""
            prosentText.text? = ""
        }
    }
    
    //Secures that you cannot scroll outside the possible subjects
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == nrOfSubjects{
            completed.contentOffset = nrOfSubjects.contentOffset
        }else{
            nrOfSubjects.contentOffset = completed.contentOffset
        }
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
    
    //This function runs when you select a row.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(fag[row] != "Click here to choose a subject"){
            self.textBox.text? = fag[row]
            subject = fag[row].components(separatedBy: " ")[0]
            assignmentsText.isHidden = false
            printFag()
        }
        else{
            self.textBox.text? = fag[row]
            nrOfSubjects.text? = ""
            completed.text? = ""
            assignmentsText.isHidden = true
            prosentText.text? = ""
        }
        nrOfSubjects.isHidden = false
        completed.isHidden = false
        prosentText.isHidden = false
        self.dropDown.isHidden = true
        
    }
    
    //Shows the dropdown when textfield is pushed.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.textBox {
            self.dropDown.isHidden = false
            nrOfSubjects.isHidden = true
            completed.isHidden = true
            assignmentsText.isHidden = true
            prosentText.isHidden = true
            textField.endEditing(true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
