//
//  CreationViewController.swift
//  MAD2
//
//  Created by chia seed on 5/22/19.
//  Copyright © 2019 Chia E. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerOneTextField: UITextField!
    @IBOutlet weak var answerTwoTextField: UITextField!
    @IBOutlet weak var answerThreeTextField: UITextField!
    @IBOutlet weak var answerFourTextField: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTwoTextField.text = initialAnswer
    }
    
    //dismiss view controller cancel + done
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        //get text from fields
        let questionText = questionTextField.text
        let answerOneText = answerOneTextField.text
        let answerTwoText = answerTwoTextField.text
        let answerThreeText = answerThreeTextField.text
        let answerFourText = answerFourTextField.text
        
        //input validation: check if empty
        if (questionText == nil || answerOneText == nil || answerTwoText == nil || answerThreeText == nil || answerFourText == nil || questionText!.isEmpty || answerOneText!.isEmpty || answerTwoText!.isEmpty || answerThreeText!.isEmpty || answerFourText!.isEmpty) {
            
            //error alert
            let alert = UIAlertController(title: "Missing text", message: "Please enter a question and an answer.", preferredStyle: .alert)
            present(alert, animated: true)
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
        } else {
            //update the flashcard
            flashcardsController.updateFlashcard(question: questionText!, answerOne: answerOneText!, answerTwo: answerTwoText!, answerThree: answerThreeText!, answerFour: answerFourText!)
    
            dismiss(animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
