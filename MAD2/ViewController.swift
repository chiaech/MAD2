//
//  ViewController.swift
//  MAD2
//
//  Created by chia seed on 5/21/19.
//  Copyright © 2019 Chia E. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answerOne: String
    var answerTwo: String
    var answerThree: String
    var answerFour: String
}

class ViewController: UIViewController{

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
   
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    @IBOutlet weak var btnOptionFour: UIButton!
    
    @IBOutlet weak var btnNewCard: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //array to hold flashcards
    var flashcards = [Flashcard]()
    
    //flashcard index
    var currentIndex = 0
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        readSavedFlashcards()
        viewSetup()
        
        //if empty, add initial flashcard
        if flashcards.count == 0 {
            updateFlashcard(question: "who was the first man on the moon?", answerOne: "elon musk", answerTwo: "niel armstrong", answerThree: "bill bye", answerFour: "sparky")
        } else {
            updateLabels()
            updatePreviousNextButtons()
        }
    }
    
    func viewSetup(){
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
    
    @IBAction func didTapOnPrevious(_ sender: Any) {
        //decrease current index
        currentIndex = currentIndex - 1
        
        //update labels
        updateLabels()
        
        //update buttons
        updatePreviousNextButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        //increase current index
        currentIndex = currentIndex + 1
        
        //update labels
        updateLabels()
        
        //update buttons
        updatePreviousNextButtons()
    }
    
    
    func updateFlashcard(question:String, answerOne: String, answerTwo: String, answerThree: String, answerFour: String){
        
        let flashcard = Flashcard(question: question, answerOne: answerOne, answerTwo: answerTwo, answerThree: answerThree, answerFour: answerFour)

        frontLabel.text = question
        backLabel.text = answerOne
        btnOptionOne.setTitle(answerOne, for: .normal)
        btnOptionTwo.setTitle(answerTwo, for: .normal)
        btnOptionThree.setTitle(answerThree, for: .normal)
        btnOptionFour.setTitle(answerFour, for: .normal)
        
        //add flashcard in array
        flashcards.append(flashcard)
        
        //logging to consol
        print("added new flashcard")
        print("we have \(flashcards.count) flashcards")
        currentIndex = flashcards.count - 1
        print("our current index is \(currentIndex)")
        
        //update buttons
        updatePreviousNextButtons()
        updateLabels()
    }
    
    func updatePreviousNextButtons(){
        //disable previous button if at the beginning
        if currentIndex == 0{
            previousButton.isEnabled = false
        } else {
            previousButton.isEnabled = true
        }
        
        //disable next button if at the end
        if currentIndex == flashcards.count - 1{
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }
    
    func updateLabels(){
        //get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answerOne
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

    //function to store the array
    func saveAllFlashcardsToDisk(){
        
        //from flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String : String] in
            return ["question": card.question, "answerOne": card.answerOne, "answertwo": card.answerTwo, "answerThree": card.answerThree,
                "answerFour": card.answerFour]
        }
        
        //save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        //log it
        print("flashcards saved to UserDefaults")
    }

    //reading from disk
    func readSavedFlashcards(){
        
        //read dictionary array from disk (if any)
        if let dicitonaryArray = UserDefaults.standard.array(forKey: "flashcards") as?  [[String: String]] {
            
            //in here we know for sure we have a dictionary array
            let savedCards = dicitonaryArray.map {dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answerOne: dictionary["answerOne"]!, answerTwo: dictionary["answerTwo"]!, answerThree: dictionary["answerthree"]!, answerFour: dictionary["answerFour"]!)
            }
            
            //put all our flashcards into our array
            flashcards.append(contentsOf: savedCards)
        }
    }
}
