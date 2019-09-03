//
//  ViewController.swift
//  Ball
//
//  Created by Valeriia Podolska on 8/19/19.
//  Copyright © 2019 Valeriia Podolska. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, AddAnswerDelegate {
    
    var answerDataModel = AnswerDataModel()
    var randomBallIndex: Int = 0
    let predictionURL : String = "https://8ball.delegator.com/magic/JSON/Ultimate_Question_of_Life"
    
   
    @IBOutlet weak var answerViewed: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerViewed.text = "Press Ball or shake Phone"
    }
    
    //
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        getAnswerData(url: predictionURL)
    }

    @IBAction func ballButtonPressed(_ sender: UIButton) {
        
        getAnswerData(url: predictionURL)
        
    }
    
    func getAnswerData(url: String) {
        Alamofire.request(predictionURL, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let answerJSON : JSON = JSON(response.result.value!)
                self.updateAnswerData(json: answerJSON)
                
            } else {
                self.answerUpdate()
            }
        }
    }
    
    func answerUpdate() {
        randomBallIndex = Int.random(in: 0 ... answerDataModel.offlineText.count-1)
        answerViewed.text = answerDataModel.offlineText[randomBallIndex]
        print("Offline")
    }
    
    func updateAnswerData(json : JSON) {
        let answerResult = json["magic"]["answer"].string
        answerViewed.text = answerResult
        
    }
    
    func userEnteredANewAnswer(newAnswer: String) {
        answerDataModel.offlineText.append(newAnswer)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSettings" {
            let destinationVC = segue.destination as! SettingsViewController
            destinationVC.delegate = self
        }
    }
}

