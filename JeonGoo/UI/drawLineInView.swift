//
//  drowLineInView.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/06/02.
//

import Foundation
import UIKit

extension UIView {
    func drawBorder(
        toLeft left: Bool = false,
        toRight right: Bool = false,
        toTop top: Bool = false,
        toBottom bottom: Bool = false,
        borderColor color: UIColor,
        borderWidth width: CGFloat
    ) {
        
    }
    func addBorder(
            toSide options: BorderOptions,
            color: UIColor,
            borderWidth width: CGFloat
        ) {
            // options에 .top이 포함되어있는지 확인
            if options.contains(.top) {
                // 이미 해당 사이드에 경계선이 있는지 확인하고, 있으면 제거
                if let exist = layer.sublayers?.first(where: { $0.name == "top" }) {
                    exist.removeFromSuperlayer()
                }
                let border: CALayer = CALayer()
                border.borderColor = color.cgColor
                border.name = "top"
                // 현재 UIView의 frame 정보를 통해 경계선이 그려질 레이어의 영역을 지정
                border.frame = CGRect(
                    x: 5, y: 0,
                    width: frame.size.width, height: width)
                border.borderWidth = width
                // 현재 그려지고 있는 UIView의 layer의 sublayer중에 가장 앞으로 추가해줌
                let index = layer.sublayers?.count ?? 0
                layer.insertSublayer(border, at: UInt32(index))
            }
            /**
            각 사이드에 동일한 과정을 적용
            */
        }
}

struct BorderOptions: OptionSet {
    let rawValue: Int
    
    static let top = BorderOptions(rawValue: 1 << 0)
    static let left = BorderOptions(rawValue: 1 << 1)
    static let bottom = BorderOptions(rawValue: 1 << 2)
    static let right = BorderOptions(rawValue: 1 << 3)
    
    static let horizontal: BorderOptions = [.left, .right]
    static let vertical: BorderOptions = [.top, .bottom]
}
