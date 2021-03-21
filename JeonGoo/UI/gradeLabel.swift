//
//  gradeLabel.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/19.
//

import Foundation
import UIKit
class grageLable {
    init(label : UILabel) {
        if label.text == "new" {
            label.textColor = #colorLiteral(red: 0.9094272256, green: 0.2923271656, blue: 0.2339404225, alpha: 1)
            label.text = "미개봉"
        }
        if searchData[indexPath.row].isGenuine {
            cell.grade.text! = cell.grade.text! + "  정품인증"
            let attributedStr = NSMutableAttributedString(string: cell.grade.text!)
            attributedStr.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.1567805707, green: 0.5004235506, blue: 0.7245382667, alpha: 1), range: (cell.grade.text as! NSString).range(of: "정품인증"))

            cell.grade.attributedText = attributedStr
        }
        searchData[indexPath.row].grade = cell.grade.text!
        
        cell.item.text = searchData[indexPath.row].name
        
        if searchData[indexPath.row].isReserved {
            cell.item.text! = "예약중  " + cell.item.text!
            let attributedStr = NSMutableAttributedString(string: cell.item.text!)
            attributedStr.addAttribute(.foregroundColor, value: #colorLiteral(red: 0, green: 0.5935456157, blue: 0.04135202616, alpha: 1), range: (cell.item.text as! NSString).range(of: "예약중"))

            cell.item.attributedText = attributedStr
        }
    }
}
