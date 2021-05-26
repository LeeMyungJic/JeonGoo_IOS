//
//  MakeUnderLine.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/28.
//

import Foundation
import UIKit

func MakeUnderLineInView(target: UIView) -> UIView {
    let lineView = UIView(frame: CGRect(x: 0, y: target.frame.height - 10, width: target.frame.size.width*0.93, height: 1.8))
    lineView.backgroundColor = #colorLiteral(red: 1, green: 0.674518168, blue: 0, alpha: 1)
    return lineView
}

func MakeUnderLineInStackView(target: UIStackView) -> UIStackView {
    let lineView = UIStackView(frame: CGRect(x: 0, y: -10, width: target.frame.size.width*0.93, height: 1.8))
    lineView.backgroundColor = #colorLiteral(red: 1, green: 0.674518168, blue: 0, alpha: 1)
    return lineView
}
