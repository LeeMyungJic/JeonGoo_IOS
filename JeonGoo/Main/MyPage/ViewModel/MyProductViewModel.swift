//
//  MyProductViewModel.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/17.
//

import Foundation

class MyProductViewModel: NSObject {
    let model:Model = Model()
    var productsData = [MyProduct]()
    
    override init() {
        let data1 = model.getProducts(subURL: "")
        let data2 = NSMutableArray()
        for i in 0..<data1.count {
            let productData = data1
            let name = productData[i].name
            let image = productData[i].image
            let price = productData[i].price
            let like = productData[i].like
            let grade = productData[i].grade
            let status = productData[i].status
            
            productsData.append(MyProduct(image: image, name: name, price: price, like: like, grade: grade, status: status))
        }
    }
}
