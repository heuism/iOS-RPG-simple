//
//  ViewController.swift
//  iOS-exercise-oop-game
//
//  Created by Hien Tran on 5/07/2016.
//  Copyright © 2016 HienTran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let MAX_TOTAL = 200
    
    @IBOutlet weak var player1Img: UIImageView!
    @IBOutlet weak var player2Img: UIImageView!
    @IBOutlet weak var displayResult: UILabel!
    
    @IBOutlet weak var resetBtnBG: UIButton!
    @IBOutlet weak var resetBtnLbl: UIButton!
    
    @IBOutlet weak var player1AtkBG: UIButton!
    @IBOutlet weak var player1AtkLbl: UIButton!
    
    @IBOutlet weak var player2AtkBG: UIButton!
    @IBOutlet weak var player2AtkLbl: UIButton!

    var player1Image: UIImage!
    var player2Image: UIImage!
    
    var player1: Character!
    var player2: Character!
    
    @IBOutlet weak var player2HP: UILabel!
    @IBOutlet weak var player1HP: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initData()
    }

    @IBAction func BtnPress(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            player2.gotHit(hitpoint: player1.playerAttackPwr)
            updateHP(player: player2)
            updateResult(result: "Player 1 got hit \(player2.playerAttackPwr)")
            player2AtkBG.isEnabled = false
            player2AtkLbl.isEnabled = false
            Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.reEnableTheAttack), userInfo: nil, repeats: false)
        case 2:
            player1.gotHit(hitpoint: player2.playerAttackPwr)
            updateHP(player: player1)
            updateResult(result: "Player 1 got hit \(player1.playerAttackPwr)")
            player1AtkBG.isEnabled = false
            player1AtkLbl.isEnabled = false
            Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.reEnableTheAttack), userInfo: nil, repeats: false)
        case 3:
            initData()
        default:
            print("")
        }
        if checkIfDead() {
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
        player1 = Character(img: player1Image, name: "HienTran", hp: 130, pwr: 70)
        updateHP(player: player1)
        player2 = Character(img: player2Image, name: "DuongPhan", hp: 100, pwr: 100)
        updateHP(player: player2)
    }
    
    func updateHP(player: Character) {
        if player.isTheSame(character: player1) {
            if player.isAlive() {
                player1HP.text = "\(player1.playerHP) HP"
            }
            else {
                player1HP.text = ""
                updateResult(result: "Player1 die!!!")
            }
        }
        else{
            if player.isAlive() {
                player2HP.text = "\(player2.playerHP) HP"
            }
            else {
                player2HP.text = ""
                updateResult(result: "Player2 die!!!")
            }
        }
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

