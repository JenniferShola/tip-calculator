//
//  ViewController.swift
//  tip karma
//
//  Created by Shola Oyedele on 9/14/16.
//  Copyright © 2016 Jennifer Shola. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var personsField: UITextField!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipRateField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    
    @IBOutlet weak var personsIcon: UIImageView!
    @IBOutlet weak var percentIcon: UILabel!
    
    @IBOutlet weak var calcView: UIImageView!
    @IBOutlet weak var calcTotalView: UIImageView!
    
    let light_purple = UIColor.init(red: (142.0/255.0), green: (176.0/255.0), blue: (255.0/255.0), alpha: 0.33)
    
    let light_yellow = UIColor.init(red: (255.0/255.0), green: (247.0/255.0), blue: (54.0/255.0), alpha: 0.33)
    
    var defaults: NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
    var color: Int {
        get{
            return defaults.integerForKey("color") ?? 0
        }
        set(value) {
            defaults.setInteger(value, forKey: "color")
        }
    }
    var persons: Int {
        get{
            return defaults.integerForKey("persons") ?? 1
        }
        set(value) {
            defaults.setInteger(value, forKey: "persons")
        }
    }
    var bill: Double {
        get{
            return defaults.doubleForKey("bill") ?? 0.0
        }
        set(value) {
            defaults.setDouble(value, forKey: "bill")
        }
    }
    var tip: Double {
        get{
            return defaults.doubleForKey("tipRate") ?? 0.18
        }
        set(value) {
            defaults.setDouble(value, forKey: "tipRate")
        }
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(sender: AnyObject) {
        
        if !((personsField.text!).isEmpty) {
            persons = Int(personsField.text!)! ?? persons
            if (persons <= 0) {
                personsField.placeholder = "1"
                personsField.text = ""
                persons = 1
            }
        }
        
        if !((billField.text!).isEmpty) {
            bill = Double(billField.text!)! ?? 0.0
        }
        
        if !((tipRateField.text!).isEmpty) {
            tip = (Double(tipRateField.text!)! ?? 18.0)
            tip *= 0.01
        }
        
        let tipCalc = tip * bill
        let total = bill + tipCalc
        let split = (bill + tipCalc) / Double(persons)
        
        tipLabel.text = String(format: "$%.2f", tipCalc)
        totalLabel.text = String(format: "$%.2f", total)
        splitLabel.text = String(format: "$%.2f", split)
        
    }
    
    func updateFieldText() {
        tipRateField.placeholder = String(Double(tip*100))
        personsField.placeholder = String(persons)
        billField.placeholder = String(bill)
        tipRateField.text = ""
        personsField.text = ""
        billField.text = ""
    }
    
    func updateColor() {
        if (color == 0) {
            calcView.backgroundColor = light_purple
            calcTotalView.backgroundColor = light_purple.colorWithAlphaComponent(0.6)
        } else {
            calcView.backgroundColor = light_yellow
            calcTotalView.backgroundColor = light_yellow.colorWithAlphaComponent(0.67)
        }
    }
    
    func runAnimations() {
        UIView.animateWithDuration(2, animations: {
            self.billField.alpha = 1.0
        })
        UIView.animateWithDuration(3, animations: {
            self.personsField.alpha = 1.0
            self.personsIcon.alpha = 0.65
            self.tipRateField.alpha = 1.0
            self.percentIcon.alpha = 0.75
        })
    }
    
    func updateScreen() {
        updateColor()
        updateFieldText()
        calculateTip(billField)
    }
    
    func hideContent() {
        self.billField.alpha = 0.0
        self.personsField.alpha = 0.0
        self.personsIcon.alpha = 0.0
        self.tipRateField.alpha = 0.0
        self.percentIcon.alpha = 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideContent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        updateScreen()
        billField.becomeFirstResponder()
        super.viewWillAppear(animated)
        print("view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        runAnimations()
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        defaults.synchronize()
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }

}

