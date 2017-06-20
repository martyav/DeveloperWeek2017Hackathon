//
//  ViewController.swift
//  DeveloperWeek2017Hackathon
//
//  Created by Ana Ma on 6/19/17.
//  Copyright © 2017 Ana Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var messageField: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func sendSMSButtonPressed(_ sender: UIButton) {
        
        ZangManager.shared.sendSMS(toNumber: "9173795525", bodyMessage: "New live stream available on zamhack://zang")
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
