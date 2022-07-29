//
//  ViewController.swift
//  seed
//
//  Created by ebb on 26.07.2022.
//

import UIKit

class ViewController: UIViewController {

    
    //veriables
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var score = 0
    var highScore = 0
    var köstebekArry = [UIImageView]()
    
    //wievs
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var köstebek1: UIImageView!
    @IBOutlet weak var köstebek2: UIImageView!
    @IBOutlet weak var köstebek3: UIImageView!
    @IBOutlet weak var köstebek4: UIImageView!
    @IBOutlet weak var köstebek5: UIImageView!
    @IBOutlet weak var köstebek6: UIImageView!
    @IBOutlet weak var köstebek7: UIImageView!
    @IBOutlet weak var köstebek8: UIImageView!
    @IBOutlet weak var köstebek9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
            
        }
        
        counter = 25
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
       
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideköstbek), userInfo: nil, repeats: true)
      
        //images
        köstebek1.isUserInteractionEnabled = true
        köstebek2.isUserInteractionEnabled = true
        köstebek3.isUserInteractionEnabled = true
        köstebek4.isUserInteractionEnabled = true
        köstebek5.isUserInteractionEnabled = true
        köstebek6.isUserInteractionEnabled = true
        köstebek6.isUserInteractionEnabled = true
        köstebek7.isUserInteractionEnabled = true
        köstebek8.isUserInteractionEnabled = true
        köstebek9.isUserInteractionEnabled = true

        let recognizer1 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        
        köstebek1.addGestureRecognizer(recognizer1)
        köstebek2.addGestureRecognizer(recognizer2)
        köstebek3.addGestureRecognizer(recognizer3)
        köstebek4.addGestureRecognizer(recognizer4)
        köstebek5.addGestureRecognizer(recognizer5)
        köstebek6.addGestureRecognizer(recognizer6)
        köstebek7.addGestureRecognizer(recognizer7)
        köstebek8.addGestureRecognizer(recognizer8)
        köstebek9.addGestureRecognizer(recognizer9)
        
        köstebekArry = [köstebek1,köstebek2,köstebek3,köstebek4,köstebek5,köstebek6,köstebek7,köstebek8,köstebek9]
      
        hideköstbek()
      
        
    }
   
    @objc func hideköstbek() {
        
        for köstebek in köstebekArry{
            köstebek.isHidden = true
        }
    
        let random = Int(arc4random_uniform(UInt32(köstebekArry.count - 1)))
        köstebekArry[random].isHidden = false
            
        
    }
        @objc func increaseScore() {
      
       score += 1
       scoreLabel.text = "Score: \(score)"
        
        
        print("yakaladın.")
    }
    
    @objc func countDown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            print("timer bitti")
            timer.invalidate() //timer duracak.
            hideTimer.invalidate()
            
            for köstebek in köstebekArry{
                köstebek.isHidden = true
            }
           
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore:\(self.highScore)"
                UserDefaults.standard.set(self.highScore,forKey: "highScore")
            }
            
            
            let alert = UIAlertController(title: "Time's up", message: "Do you want to play again?", preferredStyle: .alert)
            
            let OKButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         
            let replayButton = UIAlertAction(title: "Replay", style: .default) { (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "score:\(self.score)"
                self.counter = 25
                self.timeLabel.text = String(self.counter)
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
               
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideköstbek), userInfo: nil, repeats: true)
              
                
                
            }
            
            alert.addAction(OKButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true,completion: nil)
            
        }
      
        print("timer")
        
        
    }
}

