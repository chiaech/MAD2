//
//  ViewController.swift
//  MAD2
//
//  Created by chia seed on 5/21/19.
//  Copyright © 2019 Chia E. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    @IBOutlet weak var btnOptionFour: UIButton!
    
    @IBOutlet weak var btnNewCard: UIButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //rounded corners
        card.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        btnOptionOne.layer.cornerRadius = 20.0
        btnOptionTwo.layer.cornerRadius = 20.0
        btnOptionThree.layer.cornerRadius = 20.0
        btnOptionFour.layer.cornerRadius = 20.0
        
        //rounded corners clip labels inside
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        btnOptionOne.clipsToBounds = true
        btnOptionTwo.clipsToBounds = true
        btnOptionThree.clipsToBounds = true
        btnOptionFour.clipsToBounds = true
        
        //shadow
        card.layer.shadowRadius = 10.0
        card.layer.shadowOpacity = 0.1
        
        //option button width
        btnOptionOne.layer.borderWidth = 2.0
        btnOptionTwo.layer.borderWidth = 2.0
        btnOptionThree.layer.borderWidth = 2.0
        btnOptionFour.layer.borderWidth = 2.0
        
        //option button colored outline
        btnOptionOne.layer.borderColor = #colorLiteral(red: 1, green: 0.4261097724, blue: 0.0001922522367, alpha: 1)
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 1, green: 0.4261097724, blue: 0.0001922522367, alpha: 1)
        btnOptionThree.layer.borderColor = #colorLiteral(red: 1, green: 0.4261097724, blue: 0.0001922522367, alpha: 1)
        btnOptionFour.layer.borderColor = #colorLiteral(red: 1, green: 0.4261097724, blue: 0.0001922522367, alpha: 1)
    }

    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            
            if self.frontLabel.isHidden {
                self.frontLabel.isHidden = false
            } else {
                self.frontLabel.isHidden = true
            }
        })
    }
    
    func updateFlashcard(question:String, answerOne: String, answerTwo: String?, answerThree: String?, answerFour: String?){
        
//        let flashcard = Flashcard(question: question, answer: answer, answer2: answer2, answer3: answer3)

        frontLabel.text = question
        backLabel.text = answerOne
        btnOptionOne.setTitle(answerTwo, for: .normal)
        btnOptionTwo.setTitle(answerOne, for: .normal)
        btnOptionThree.setTitle(answerThree, for: .normal)
        btnOptionFour.setTitle(answerFour, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //we know the destination of the segue is Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        //we know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        //set flashcardsController property to self
        creationController.flashcardsController = self
        
        //edit option
        if segue.identifier == "EditSegue"{
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        btnOptionTwo.isHidden = false
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
    
    @IBAction func didTapOptionFour(_ sender: Any) {
        btnOptionFour.isHidden = true
    }
}
