//
//  CustomText.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/22.
//

import Foundation

import Foundation
import UIKit
class CustomText: UITextField {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 1, green: 0.674518168, blue: 0, alpha: 1)
        
    }
}
