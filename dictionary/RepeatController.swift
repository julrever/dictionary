//
//  RepeatController.swift
//  dictionary
//
//  Created by jul on 10.04.17.
//  Copyright © 2017 jul. All rights reserved.
//

import UIKit

class RepeatController: UIViewController {
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translationTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func missButton(_ sender: UIButton) {
        
    }
    
    @IBAction func readyButton(_ sender: UIButton) {
        
    }

}
