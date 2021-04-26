//
//  Product.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import Foundation

enum Grade: String, CodingKey{
    case HIGH = "A등급"
    case INTERMEDIATE_HIGH = "B등급"
    case INTERMEDIATE = "C등급"
    case INTERMEDIATE_LOW = "D등급"
    case LOW = "E등급"
    case NONE = "Nil"
}

enum Status: String, CodingKey {
    case USED = "중고"
}

struct Product {
    var name : String
    var price : Int
    var likes : Int
    var count : Int
    var grade : String
    var detail : String
    var isReserved : Bool
    var isGenuine : Bool
}

class getProduct: NSObject {
    var id: Int
    var name: String
    var price: Int
    var productGrade : Grade
    var useStatus : Status
    init(id: Int, name: String, price: Int, productGrade: Grade, useStatus: Status) {
        self.id = id
        self.name = name
        self.price = price
        self.productGrade = productGrade
        self.useStatus = useStatus
    }
}

class ProductModel: NSObject {
    func getProductsData() {
//        print("ProDuctModel !!")
//        let subUrl = "/products"
//        var gg: NSDictionary = [
//            "dd" : "dd"
//        ]
//
//        Get(subURL: subUrl, success: { getValue in
////            let temp = getValue["data"] as! NSArray
////            for i in temp {
////                if let tt = i as? NSDictionary {
////                    print("description : \(tt["description"] as! String)")
////                }
////            }
//            gg = getValue
//            return getValue
//
//        }, fail: {
//
//          return gg
//        })
    }
}
