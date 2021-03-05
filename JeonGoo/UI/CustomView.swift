//
//  CustomStack.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/05.
//

import Foundation
import UIKit
class CustomView: UIView {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 10
        
    }
}
