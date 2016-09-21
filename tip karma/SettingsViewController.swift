//
//  SettingsViewController.swift
//  tip karma
//
//  Created by Shola Oyedele on 9/15/16.
//  Copyright © 2016 Jennifer Shola. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var splitField: UITextField!
    @IBOutlet weak var tipRateField: UITextField!
    @IBOutlet weak var colorControl: UISegmentedControl!
    
    var defaults: NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
    var colorTheme: Int {
        get{
            return defaults.integerForKey("color") ?? 0
        }
        set(value) {
            defaults.setInteger(value, forKey: "color")
        }
    }
    var shareNumber: Int {
        get{
            return defaults.integerForKey("persons") ?? 1
        }
        set(value) {
            defaults.setInteger(value, forKey: "persons")
        }
    }
    var tipRate: Double {
        get{
            return defaults.doubleForKey("tipRate") ?? 0.0
        }
        set(value) {
            defaults.setDouble(value, forKey: "tipRate")
        }
    }
    
    @IBAction func shareNumberChanged(sender: AnyObject) {
        if !((splitField.text!).isEmpty) {
            shareNumber = Int(splitField.text!)! ?? 4
            if (shareNumber <= 0) {
                splitField.placeholder = "1"
                splitField.text = ""
                shareNumber = 1
            }
        }
    }
    
    @IBAction func tipRateChanged(sender: AnyObject) {
        if !((tipRateField.text!).isEmpty) {
            tipRate = (Double(tipRateField.text!)! * 0.01) ?? tipRate
            if (tipRate <= 0.0) {
                tipRateField.placeholder = "18"
                tipRateField.text = ""
                tipRate = 0.18
            }
        }
    }
    
    @IBAction func colorThemeChanged(sender: AnyObject) {
        colorTheme = colorControl.selectedSegmentIndex
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func updateScreen() {
        colorControl.selectedSegmentIndex = colorTheme
        tipRateField.placeholder = String(Double((tipRate)*100))
        splitField.placeholder = String(shareNumber)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        updateScreen()
        super.viewWillAppear(animated)
        print("view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
