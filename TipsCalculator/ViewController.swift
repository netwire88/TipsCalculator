//
//  ViewController.swift
//  TipsCalculator
//
//  Created by Dean Chen on 6/28/14.
//  Copyright (c) 2014 Corklabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet var taxPctSlider: UISlider
    @IBOutlet var totalTextField: UITextField
    @IBOutlet var taxPctLabel: UILabel
    @IBOutlet var resultsTextView: UITextView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func taxPercentageChanged(sender: AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }
    
    @IBAction func calculateTapped(sender: AnyObject) {
        // 1
        tipCalc.total = Double(totalTextField.text.bridgeToObjectiveC().doubleValue)  //Should use NSString instead
        // 2
        let possibleTips = tipCalc.returnPossibleTips()
        var results = ""
        // 3, enumerate through both keys and values of a dictionary at the same time
//        for (tipPct, tipValue) in possibleTips {
//            // 4
//            results += "\(tipPct)%: \(tipValue)\n"
//        }
        var keys = Array(possibleTips.keys)  //get keys in dictionary
        sort(keys)  //sort keys
        for tipPct in keys {  //loop through keys array, find item in dictionary, and concantenate
            let tipValue = possibleTips[tipPct]!  //forced unwrapping
            let prettyTipValue = String(format:"%.2f", tipValue)  //truncate to 2 decimal places
            results += "\(tipPct)%: \(prettyTipValue)\n"
        }
        // 5
        resultsTextView.text = results
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        totalTextField.resignFirstResponder()
    }
    
    
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    func refreshUI() {
        // 1
        totalTextField.text = String(tipCalc.total)
        // 2
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        // 3
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        // 4
        resultsTextView.text = ""  //clear result view until user clicks button
    }
}

