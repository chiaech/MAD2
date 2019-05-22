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
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func didTapOnFlashcard(_ sender: Any){
    
        if self.frontLabel.isHidden {
            self.frontLabel.isHidden = false
        } else {
            self.frontLabel.isHidden = true
        }
    }

}

