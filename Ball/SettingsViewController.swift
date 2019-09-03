//
//  SettingsViewController.swift
//  Ball
//
//  Created by Valeriia Podolska on 9/1/19.
//  Copyright © 2019 Valeriia Podolska. All rights reserved.
//

import UIKit

protocol AddAnswerDelegate {
    func userEnteredANewAnswer(newAnswer : String)
}

class SettingsViewController: UIViewController {

    var delegate : AddAnswerDelegate?
    
    @IBOutlet weak var addAnswerTextField: UITextField!
    
    @IBAction func addAnswerPressed(_ sender: UIButton) {
        
        let customAnswer = addAnswerTextField.text!
        
        delegate?.userEnteredANewAnswer(newAnswer: customAnswer)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
