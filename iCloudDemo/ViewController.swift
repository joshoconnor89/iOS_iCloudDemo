//
//  ViewController.swift
//  iCloudDemo
//
//  Created by Kristian Secor on 4/1/15.
//  Copyright (c) 2015 Kristian Secor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var displayValue: UILabel!

    var keyStore:NSUbiquitousKeyValueStore?
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        keyStore = NSUbiquitousKeyValueStore()
        let storedString = keyStore?.stringForKey("paid")
        println("Value is  \(storedString)")
        if let stringValue = storedString {
           displayValue.text = stringValue
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "ubiquitousKeyValueStoreDidChange", name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification, object: keyStore)
        
        //not done yet.
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    func ubiquitousKeyValueStoreDidChange(){
        let alert = UIAlertController(title: "change detected", message: "iCloud key name paid has a change", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
        displayValue.text = keyStore?.stringForKey("paid")
        
        
        
        
    }
    
    
    
    @IBAction func saveKey(sender: AnyObject) {
        //very important line
        keyStore?.setString(textField.text, forKey: "paid")
        keyStore?.synchronize()
        
        

        
        
        // let defaults = NSUserDefaults.standardUserDefaults()
        // defaults.setObject(textField.text, forKey: "paid")
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

