//
//  getProductViewModel.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/04/21.
//

import Foundation

class getProductViewModel: NSObject {
    let model: ProductModel = ProductModel()
    var productsData: NSArray!
    
    override init() {
        let tt = model.getProductsData()
        print(tt)
//        let data1 = model.getProductsData()["data"] as! NSArray
//        let data2 = NSMutableArray()
//        for i in 0..<data1.count {
//            let productTemp = data1[i] as! NSDictionary
//            let id = productTemp["id"] as! Int
//            let name = productTemp["name"] as! String
//            let price = productTemp["price"] as! Int
//            var productGrade : Grade
//            var useStatus : Status
//
//            data2.add(getProduct(id: id, name: name, price: price, productGrade: .HIGH, useStatus: .USED))
//        }
//        productsData = NSArray(array: data2)
    }
}
