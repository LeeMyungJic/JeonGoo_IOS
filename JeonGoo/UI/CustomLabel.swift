//
//  CustomLabel.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/19.
//

import Foundation
import UIKit
class CustomLabel{
    func setLabel(text: String, code: Int) -> UILabel {
        var newLabel = UILabel()
        newLabel.text = text
        newLabel.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        
        switch code {
        
        case 1:
            newLabel.textColor = #colorLiteral(red: 1, green: 0.674518168, blue: 0, alpha: 1)
            var attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.1567805707, green: 0.5004235506, blue: 0.7245382667, alpha: 1), range: (text as! NSString).range(of: "정품인증"))
            attributedStr.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.9094272256, green: 0.2923271656, blue: 0.2339404225, alpha: 1), range: (text as! NSString).range(of: "미개봉"))
            newLabel.attributedText = attributedStr
        case 2:
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(.foregroundColor, value: #colorLiteral(red: 0, green: 0.5935456157, blue: 0.04135202616, alpha: 1), range: (text as! NSString).range(of: "예약중"))
            newLabel.attributedText = attributedStr
        default:
            print(" ")
        }
        return newLabel
    }
}
/*
 if searchData[indexPath.row].grade == "new" {
     cell.grade.textColor = #colorLiteral(red: 0.9094272256, green: 0.2923271656, blue: 0.2339404225, alpha: 1)
     cell.grade.text = "미개봉"
 }
 else {
     cell.grade.text = searchData[indexPath.row].grade
 }
 if searchData[indexPath.row].isGenuine {
     cell.grade.text! = cell.grade.text! + "  정품인증"
     let attributedStr = NSMutableAttributedString(string: cell.grade.text!)
     attributedStr.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.1567805707, green: 0.5004235506, blue: 0.7245382667, alpha: 1), range: (cell.grade.text as! NSString).range(of: "정품인증"))

     cell.grade.attributedText = attributedStr
 }
 */
