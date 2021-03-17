//
//  MyProductViewModel.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/17.
//

import Foundation

class MyProductViewModel: NSObject {
    let model = Model()
    var productsData = [MyProduct]()
    
    override init() {
        let data1 = model.getProducts(subURL: "")
        let data2 = NSMutableArray()
        for i in 0..<data1.count {
            let imageTemp = data1[i]
        }
    }
}
