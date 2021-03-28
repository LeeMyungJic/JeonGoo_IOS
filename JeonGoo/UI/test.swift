//
//  test.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/27.
//

import Foundation
import UIKit

func addBorder(vi: UIView) {
    let border = CALayer()
    vi.border.frame = CGRect.init(x: 0, y: vi.frame.height - vi.width, width: vi.frame.width, height: vi.width)
    border.backgroundColor = color.cgColor;
    self.addSublayer(border)
}

