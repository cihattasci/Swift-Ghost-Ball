//
//  ViewController.swift
//  catchTheBall
//
//  Created by Cihat Tascı on 19.07.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeCount: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var highScore: UILabel!
    
    @IBOutlet weak var ball1: UIImageView!
    @IBOutlet weak var ball2: UIImageView!
    @IBOutlet weak var ball3: UIImageView!
    @IBOutlet weak var ball4: UIImageView!
    @IBOutlet weak var ball5: UIImageView!
    @IBOutlet weak var ball6: UIImageView!
    @IBOutlet weak var ball7: UIImageView!
    @IBOutlet weak var ball8: UIImageView!
    @IBOutlet weak var ball9: UIImageView!
    
    var scoreCount = 0
    var timeCounter = 15
    var createTimeObject = Timer()
    var hideBallTimer = Timer()
    var ballArray = [UIImageView]()
    var oldHighScore = UserDefaults.standard.integer(forKey: "highScore")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeCount.text = "Time: \(timeCounter)"
        highScore.text = "High Score: \(oldHighScore)"
        
        ball1.isUserInteractionEnabled = true
        ball2.isUserInteractionEnabled = true
        ball3.isUserInteractionEnabled = true
        ball4.isUserInteractionEnabled = true
        ball5.isUserInteractionEnabled = true
        ball6.isUserInteractionEnabled = true
        ball7.isUserInteractionEnabled = true
        ball8.isUserInteractionEnabled = true
        ball9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        
        ball1.addGestureRecognizer(recognizer1)
        ball2.addGestureRecognizer(recognizer2)
        ball3.addGestureRecognizer(recognizer3)
        ball4.addGestureRecognizer(recognizer4)
        ball5.addGestureRecognizer(recognizer5)
        ball6.addGestureRecognizer(recognizer6)
        ball7.addGestureRecognizer(recognizer7)
        ball8.addGestureRecognizer(recognizer8)
        ball9.addGestureRecognizer(recognizer9)
        
        ballArray = [ball1, ball2, ball3, ball4, ball5, ball6, ball7, ball8, ball9]
        
        createTimeObject = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(executeTimer), userInfo: nil, repeats: true)
        hideBallTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideBallImage), userInfo: nil, repeats: true)
        
        hideBallImage()
        
    }
    
    @objc func hideBallImage() {
        for ball in ballArray {
            ball.isHidden = true
        }
        
        let random = Int.random(in: 0 ..< ballArray.count - 1)
        ballArray[random].isHidden = false
    }
    
    @objc func incrementScore() {
        scoreCount += 1
        score.text = "Score: \(scoreCount)"
    }
    
    @objc func executeTimer() {
        timeCounter -= 1
        timeCount.text = "Time: \(timeCounter)"
        if timeCounter == 0 {
            createTimeObject.invalidate()
            hideBallTimer.invalidate()
            if oldHighScore < scoreCount {
                UserDefaults.standard.set(scoreCount, forKey: "highScore")
                highScore.text = "High Score: \(scoreCount)"
            }
            let alert = UIAlertController(title: "Time is Up!", message: "Do you want to start again?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Start Again", style: UIAlertAction.Style.default, handler: { action in
                self.timeCounter = 15
                self.scoreCount = 0
                self.timeCount.text = "Time: \(self.timeCounter)"
                self.score.text = "Score: \(self.scoreCount)"
                
                self.createTimeObject = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.executeTimer), userInfo: nil, repeats: true)
                self.hideBallTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideBallImage), userInfo: nil, repeats: true)
                
                self.hideBallImage()
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }


}

