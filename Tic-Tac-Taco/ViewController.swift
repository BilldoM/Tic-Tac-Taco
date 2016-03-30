//
//  ViewController.swift
//  Tic-Tac-Taco
//
//  Created by William Melvin on 3/29/16.
//  Copyright © 2016 William Melvin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //Parameters
    var activePlayer = 1 //1 = taco 2 = taco2
    var gameState = [0,0,0,0,0,0,0,0,0]
    var winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    var gameActive = true
    var buttonSound: AVAudioPlayer!
    var endGameSound: AVAudioPlayer!
    
    //Outlets
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var playerTurnLabel: UILabel!
    
    @IBAction func buttonPressed(btn: UIButton!) {
        buttonSound.play()
        updatePlayerTurn()
        
        if (gameState[btn.tag] == 0 && gameActive == true) {
            gameState[btn.tag] = activePlayer
            if activePlayer == 1 {
                btn.setImage(UIImage(named: "taco.png"), forState: .Normal)
                activePlayer = 2
            } else {
                btn.setImage(UIImage(named: "taco2.png"), forState: .Normal)
                activePlayer = 1
            }
            for combination in winningCombinations {
                if (gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]) {
                    gameActive = false
                    if gameState[combination[0]] == 1 {
                        gameOverLabel.text = "Player 1 Wins!!"
                    } else {
                        gameOverLabel.text = "Player 2 Wins!!"
                    }
                    
                        endGame()
                }
            }
            
            if gameActive == true {
                gameActive = false
                for buttonState in gameState {
                    if buttonState == 0 {
                    gameActive = true
                        
                        }
                    }
                    if gameActive == false {
                    gameOverLabel.text = "It's a Draw!!"
                    endGame()
                }
            }
        }
    }
    
    @IBAction func playAgain(sender: AnyObject!) {
            gameState = [0,0,0,0,0,0,0,0,0]
            activePlayer = 1
            gameActive = true
        
            hideLabels()
            var buttonToClear : UIButton
            for i in 0...8 {
                buttonToClear = view.viewWithTag(i) as! UIButton
                buttonToClear.setImage(nil, forState: UIControlState.Normal)
            }
        endGameSound.stop()
    
            
        }
        func endGame() {
            gameOverLabel.hidden = false
            playAgainButton.hidden = false
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 500, self.gameOverLabel.center.y)
                self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 500, self.playAgainButton.center.y)
                let path = NSBundle.mainBundle().pathForResource("applause", ofType: "mp3")
                let soundURL = NSURL(fileURLWithPath: path!)
                
                do {
                    try self.endGameSound = AVAudioPlayer(contentsOfURL: soundURL)
                    self.endGameSound.prepareToPlay()
                } catch let err as NSError {
                    print(err.debugDescription)
                }
                self.endGameSound.play()


            })
        }
    //Label tells who's turn it is
    func updatePlayerTurn() {
        if activePlayer == 2 {
            playerTurnLabel.text = "Player 1's Turn"
        } else {
            playerTurnLabel.text = "Player 2's Turn"
        }
    }
    
    func hideLabels() {
        gameOverLabel.hidden = true
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 500, gameOverLabel.center.y)
        playAgainButton.hidden = true
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 500, playAgainButton.center.y)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Animation and Hidden Labels
        hideLabels()
        
        //Sound on button pressed
        let path = NSBundle.mainBundle().pathForResource("pop", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

}


