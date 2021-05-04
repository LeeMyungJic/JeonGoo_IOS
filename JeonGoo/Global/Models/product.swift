//
//  product.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/05/03.
//

import Foundation

struct productData: Codable {
    let userShowResponse: userInfo
    let productDetailDto: productInfo

    struct userInfo: Codable {
        let name: String
        let phoneNumber: String
    }
    struct productInfo: Codable {
        let id: Int
        let name: String
        let description: String
        let price: Int
        let useStatus: String
        let productGrade: String
        let salesStatus: String
    }
}
func setGrade(value: String) -> String {
    switch value {
    case "HIGH":
        return "A등급"
    case "INTERMEDIATE_HIGH":
        return "B등급"
    case "INTERMEDIATE":
        return "C등급"
    case "INTERMEDIATE_LOW":
        return "D등급"
    case "LOW":
        return "E등급"
    case "NONE":
        return "검수중"
    default:
        return "Null"
    }
}
