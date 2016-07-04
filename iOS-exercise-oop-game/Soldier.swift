//
//  Soldier.swift
//  iOS-exercise-oop-game
//
//  Created by Hien Tran on 5/07/2016.
//  Copyright © 2016 HienTran. All rights reserved.
//

import Foundation
import UIKit

class Soldier: Character {
    
    convenience init(img: UIImage, name: String, hp: Int, pwr: Int) {
        self.init(name: name, hp: hp, pwr: pwr)
        self.characterImg = img
    }
}
