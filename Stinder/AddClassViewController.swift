//
//  AddClassViewController.swift
//  Stinder
//
//  Created by Josue Rodriguez on 4/30/18.
//  Copyright © 2018 Josue Rodriguez. All rights reserved.
//

import UIKit

class AddClassViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var courseTextField: UITextField!
    var course = ""
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        course = courseTextField.text!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
            course = courseTextField.text!
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
