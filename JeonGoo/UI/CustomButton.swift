//
//  CustomButton.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import Foundation
import UIKit

class CustomButton : UIButton{
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        let colorLiteral = #colorLiteral(red: 0.9530107379, green: 0.7626427412, blue: 0.06412496418, alpha: 1)
        self.layer.cornerRadius = 3
        self.layer.backgroundColor = colorLiteral.cgColor
        self.setTitleColor(.white, for: .normal)
        
    }
     
}
