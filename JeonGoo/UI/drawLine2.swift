//
//  drawLine2.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/27.
//

import Foundation
import UIKit
class drawLine2: UIView {
    public var shapeLayer: CAShapeLayer!

    func addUnderLine() {


        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.size.height + 3))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.size.height + 3))
        path.close()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = path.lineWidth
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        layer.addSublayer(shapeLayer)
    }
}
