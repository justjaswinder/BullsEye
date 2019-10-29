//
//  ViewController.swift
//  BullsEye
//
//  Created by MacStudent on 2019-10-25.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
     var score = 0              // add this line
    var currentValue : Int = 0
    var targetValue: Int = 0
    var round: Int = 0
    var isClicked = false
    
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var btn: UIButton!
    @IBAction func infoClicked(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var lbl: UILabel!

    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func startOver(_ sender: Any) {
         startNewGame()
         
    }
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    @IBAction func btnClicked(_ sender: Any) {
        
       showAlert1()
 
      
    }
    
    @IBAction func btnPressed(_ sender: Any) {
        togglePressed()
    }
    
    @IBAction func slider(_ sender: Any) {
        
        currentValue = lroundf(slider.value)
      //  lblSlider.text = "\(lroundf(slider.value))"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          startNewGame()
    }
    
}


extension ViewController{
    
    
       func showAlert(){
        
        
        var difference: Int
        if currentValue > targetValue {
            difference = currentValue - targetValue
        } else if targetValue > currentValue {
            difference = targetValue - currentValue
        } else {
            difference = 0
        }
        
       // let difference = abs(targetValue - currentValue)
        let points = 100 - difference
          score += points
        let message = "The value of the slider is: \(currentValue)" +
        "\nThe target value is: \(targetValue)" +
    "\nThe difference is: \(difference)"
        
        let alert = UIAlertController(title: "My Title", message: message, preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
        
          startNewRound()
    }
    
    @IBAction func showAlert1() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50 }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        score += points
        // add these lines
        
     
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title,  // change this
            message: message,
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default,
                                   handler: nil)
          alert.addAction(action)
        present(alert, animated: true, completion: nil)
        startNewRound()
    }
    func togglePressed(){
        
        isClicked.toggle()
        let label = isClicked ? "True" : "False"
        lbl.text = label
    }
    
    func startNewRound() {
          round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
         updateLabels()  // Add this line
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
    scoreLabel.text = String(score)
         roundLabel.text = String(round)
    }
}
