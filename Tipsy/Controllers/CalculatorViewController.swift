//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    var resultTo2DecimalPlaces = ""
    var buttonTitleMinusPercentSign = ""
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0

    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var zeroPctButton: UIButton!
    
    @IBOutlet weak var tenPctButton: UIButton!
    
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!

    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        //make all the button deselected
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        //select the current button
        sender.isSelected = true
        
        //get the current title of the button was pressed
        let buttonTitle = sender.currentTitle!
        
        //remove the last charecter "%" from the title
        buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        
        //turn the string into double
        let buttonTitleAsNumber = Double(buttonTitleMinusPercentSign)!
        
        //devide the percent
        tip = buttonTitleAsNumber / 100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        // set the numberOfPeople property as the value of the stepper
        numberOfPeople = Int(sender.value)
        //assaign numberOfPeople in the splitNumberLabel
        splitNumberLabel.text = String(numberOfPeople)
       
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        //get the text user typed in the billTextField
        let bill = billTextField.text!
        
        //if the text is not an empty string""
        if bill != ""{
            
            // turn the bill from string to decible places
            billTotal = Double(bill)!
            
            //multiply the bill by tip percentage and divide by the number of people to split bill
            let result = billTotal*(1 + tip) / Double(numberOfPeople)
            
            //Round the result to 2 decimal places and turn it to strings
            resultTo2DecimalPlaces = String(format: "%.2f", result)
            
            self.performSegue(withIdentifier: "goToResult", sender: self)
            
            print(resultTo2DecimalPlaces)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "goToResult"{
            let destinationVc = segue.destination as! ResultsViewController
            destinationVc.total = resultTo2DecimalPlaces
            destinationVc.person = numberOfPeople
            destinationVc.percent = buttonTitleMinusPercentSign
        }
        // Pass the selected object to the new view controller.
    }
}

