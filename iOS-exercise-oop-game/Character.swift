//
//  Character.swift
//  iOS-exercise-oop-game
//
//  Created by Hien Tran on 5/07/2016.
//  Copyright © 2016 HienTran. All rights reserved.
//

import Foundation
import UIKit

class Character {
    
    private var _playerName: String = "hero"
    private var _playerHP: Int = 100
    private var _playerAttackPwr: Int = 10
    
    private var _characterImg: UIImage?
    
    var characterImg: UIImage {
        get {
            return _characterImg!
        }
        set {
            _characterImg = newValue
        }
    }
    
    var playerName: String {
            return _playerName
    }
    
    var playerHP: Int {
        return _playerHP
    }
    
    var playerAttackPwr: Int {
        return _playerAttackPwr
    }
    
    init(name: String, hp: Int, pwr: Int) {
        self._playerName = name
        self._playerHP = hp
        self._playerAttackPwr = pwr
    }
    
    convenience init(img: UIImage, name: String, hp: Int, pwr: Int) {
        self.init(name: name, hp: hp, pwr: pwr)
        self.characterImg = img
    }
    
    func gotHit(hitpoint: Int) -> Int {
        let rand = Int(arc4random_uniform(UInt32(hitpoint)))
        _playerHP -= rand
        return rand
    }
    
    func isAlive() -> Bool {
        if playerHP <= 0 {
            return false
        }
        return true
    }
    
    func isTheSame(character: Character) -> Bool {
        if character.playerName == self.playerName {
            if character.playerHP == self.playerHP {
                if character.playerAttackPwr == self.playerAttackPwr {
                    return true
                }
            }
        }
        return false
    }
}
