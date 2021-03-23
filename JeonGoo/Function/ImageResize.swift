//
//  ImageResize.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/23.
//

import Foundation
import UIKit

func ImageResize(getImage:UIImage, size:Double) -> UIImage {
    
    let wif = 70
    var new_image : UIImage!
    let size = CGSize(width:  size  , height: size )
    
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    
    UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
    getImage.draw(in: rect)
    
    new_image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return new_image
}

