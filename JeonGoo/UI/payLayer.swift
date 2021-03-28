//
//  payLayer.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/27.
//

import Foundation
import UIKit

class payLater: UIStackView {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        self.layer.borderColor = #colorLiteral(red: 1, green: 0.674518168, blue: 0, alpha: 1)
        self.layer.borderWidth = 1
        
    }
}
