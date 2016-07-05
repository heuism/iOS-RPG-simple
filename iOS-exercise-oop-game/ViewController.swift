//
//  ViewController.swift
//  iOS-exercise-oop-game
//
//  Created by Hien Tran on 5/07/2016.
//  Copyright © 2016 HienTran. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let MAX_TOTAL = 500
    
    @IBOutlet weak var player1Img: UIImageView!
    @IBOutlet weak var player2Img: UIImageView!
    @IBOutlet weak var displayResult: UILabel!
    
    @IBOutlet weak var resetBtnBG: UIButton!
    @IBOutlet weak var resetBtnLbl: UIButton!
    
    @IBOutlet weak var player1AtkBG: UIButton!
    @IBOutlet weak var player1AtkLbl: UIButton!
    
    @IBOutlet weak var player2AtkBG: UIButton!
    @IBOutlet weak var player2AtkLbl: UIButton!
    
    var btnSound: AVAudioPlayer!

    var player1Image: UIImage!
    var player2Image: UIImage!
    
    var player1: Character!
    var player2: Character!
    
    var player1Timer: Timer?
    var player2Timer: Timer?
    
    var hitpoint: Int = 0
    
    @IBOutlet weak var player2HP: UILabel!
    @IBOutlet weak var player1HP: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let path = Bundle.main().pathForResource("Sword Swing", ofType: "wav")
//        
//        let soundURL = URL(fileURLWithPath: path!)
//        
//        do {
//            try btnSound = AVAudioPlayer(contentsOf: soundURL)
//            btnSound.prepareToPlay()
//        } catch let err as NSError {
//            print(err.debugDescription)
//        }

        let path = Bundle.main().pathForResource("Sword Swing", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        initData()
    }

    @IBAction func BtnPress(_ sender: UIButton) {
        playSound()
        switch sender.tag {
        case 1:
            if ((player2Timer?.isValid) != nil) {
                player2Timer?.invalidate()
            }
            hitpoint = player2.gotHit(hitpoint: player1.playerAttackPwr)
            updateResult(result: "\(player2.playerName) got hit \(hitpoint) dmg")
            updateHP(player: player2)
            player2AtkBG.isEnabled = false
            player2AtkLbl.isEnabled = false
            player2Timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.reEnableTheAttack), userInfo: nil, repeats: false)
        case 2:
            if ((player1Timer?.isValid) != nil) {
                player1Timer?.invalidate()
            }
            hitpoint = player1.gotHit(hitpoint: player1.playerAttackPwr)
            updateResult(result: "\(player1.playerName) got hit \(hitpoint) dmg")
            updateHP(player: player1)
            player1AtkBG.isEnabled = false
            player1AtkLbl.isEnabled = false
            player1Timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.reEnableTheAttack), userInfo: nil, repeats: false)
        case 3:
            initData()
        default:
            print("")
        }
        if checkIfDead() {
            player1Timer?.invalidate()
            player2Timer?.invalidate()
            unEnableTheAttack()
            resetBtnBG.isHidden = false
            resetBtnLbl.isHidden = false
        }
    }
    
    func reEnableTheAttack() {
        
        player2AtkBG.isEnabled = true
        player2AtkLbl.isEnabled = true
        player1AtkBG.isEnabled = true
        player1AtkLbl.isEnabled = true
    }
    
    func unEnableTheAttack() {
        
        player2AtkBG.isEnabled = false
        player2AtkLbl.isEnabled = false
        player1AtkBG.isEnabled = false
        player1AtkLbl.isEnabled = false
    }
    
    func initData() {
        generateUIImage()
        generatePlayers()
        resetBtnBG.isHidden = true
        resetBtnLbl.isHidden = true
        updateResult(result: "")
        player2AtkBG.isEnabled = true
        player2AtkLbl.isEnabled = true
        player1AtkBG.isEnabled = true
        player1AtkLbl.isEnabled = true
    }
    
    func generateUIImage() {
        player1Image = UIImage(named: "enemy.png")
        player2Image = UIImage(named: "player.png")
    }
    
    func generatePlayers() {
        player1 = Character(img: player1Image, name: "HienTran", hp: 450, pwr: MAX_TOTAL - 450)
        updateHP(player: player1)
        //player1Timer = Timer()
        player2 = Character(img: player2Image, name: "DuongPhan", hp: 420 , pwr: MAX_TOTAL - 420)
        updateHP(player: player2)
        //player2Timer = Timer()
    }
    
    func updateHP(player: Character) {
        if player.isTheSame(character: player1) {
            if player.isAlive() {
                player1HP.text = "\(player1.playerHP) HP"
            }
            else {
                player1HP.text = ""
                updateResult(result: "\(player1.playerName) die!!!")
            }
        }
        else{
            if player.isAlive() {
                player2HP.text = "\(player2.playerHP) HP"
            }
            else {
                player2HP.text = ""
                updateResult(result: "\(player2.playerName) die!!!")
            }
        }
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func updateResult(result: String) {
        displayResult.text = result
    }
    
    func checkIfDead() -> Bool {
        if !player2.isAlive(){
            return true
        }
        if !player1.isAlive() {
            return true
        }
        return false
    }
}

