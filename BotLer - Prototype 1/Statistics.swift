//
//  Statistics.swift
//  BotLer - Prototype 1
//
//  Created by Sondre Brekke on 28.03.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import UIKit

class Statistics: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var selectedSubject: UITextView!
    
    var ids: [String] = []
    var names: [String] = []
    var Comids: [String] = []
    var Comnames: [String] = []
    var subject = ""
    var antall = 0
    var fag:[String] = []
    
    @IBOutlet weak var prosentText: UITextView!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var nrOfSubjects: UITextView!
    @IBOutlet weak var completed: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prosentText.isHidden = true
        nrOfSubjects.delegate  = self
        completed.delegate  = self
        fag.append("Click here to choose a subject")
        fag += ChooseSubject.mineFag
        self.textBox.text? = fag[0]
        self.dropDown.isHidden = true
    }
    
    func printFag(){
        ids = []
        names = []
        Comids = []
        Comnames = []
        antall = 0
        let url=URL(string:"http://folk.ntnu.no/sondrbre/index.php")
        do {
            let allContactsData = try Data(contentsOf: url!)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            if let arrJSON = allContacts["data"]{
                for index in 0...arrJSON.count-1 {
                    
                    let aObject = arrJSON.objectAt(index) as! [String : AnyObject]
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
            streng += "<font color=\"black\" size=\"5.6\"><p style='display:inline'><b>Name</b></p></font><br>"
            streng2 += "<font color=\"black\" size=\"5.6\"><p style='display:inline'><b>Status</b></p></font><br>"
            var ant = 0
            for index in 0...ids.count-1 {
                if(!Comids.contains(ids[index])){
                    streng += "<font color=\"black\" size=\"5.1\"><p style='display:inline'>\(names[index])</p></font><br>"
                    streng2 += "<font color=\"red\" size=\"5.1\"><p style='display:inline'>Not completed</p></font><br>"
                }
                else{
                    streng += "<font color=\"black\" size=\"5.1\"><p style='display:inline'>\(Comnames[ant])</p></font><br>"
                    streng2 += "<font color=\"green\" size=\"5.1\"><p style='display:inline'>Completed</p></font><br>"
                    ant += 1
                }
            }

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
            let prosent:Double = round(100*(Double(Comids.count))/(Double(ids.count))*100)/100
            prosentText.text? = "You have completed " + "\(prosent)" + "% of the assignments."
        }
        else{
            nrOfSubjects.text? = ""
            completed.text? = ""
            prosentText.text? = ""
        }
    }
    
    
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(fag[row] != "Click here to choose a subject"){
            self.textBox.text? = fag[row]
            subject = fag[row].components(separatedBy: " ")[0]
            printFag()
        }
        else{
            self.textBox.text? = fag[row]
            nrOfSubjects.text? = ""
            completed.text? = ""
            prosentText.text? = ""
        }
        nrOfSubjects.isHidden = false
        completed.isHidden = false
        prosentText.isHidden = false
        self.dropDown.isHidden = true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.textBox {
            self.dropDown.isHidden = false
            nrOfSubjects.isHidden = true
            completed.isHidden = true
            prosentText.isHidden = true
            textField.endEditing(true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
