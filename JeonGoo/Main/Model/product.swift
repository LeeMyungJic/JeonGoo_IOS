//
//  product.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/05/03.
//

import Foundation

struct productData: Codable {
    var interestCount: Int
    let userShowResponse: userInfo
    let productDetailDto: productInfo
    
    private enum CodingKeys: String, CodingKey {
        case interestCount, userShowResponse, productDetailDto
    }

    struct userInfo: Codable {
        let name: String
        let phoneNumber: String
    }
    struct productInfo: Codable {
        var hitCount: Int
        let id: Int
        let name: String
        let description: String
        let price: Int
        let useStatus: String
        let productGrade: String
        let salesStatus: String
        
        private enum CodingKeys: String, CodingKey {
            case hitCount, id, name, description, price, useStatus, productGrade, salesStatus
        }
    }
}

extension productData {
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        interestCount = (try? values.decode(Int.self, forKey: .interestCount)) ?? -1
        userShowResponse = (try? values.decode(userInfo.self, forKey: .userShowResponse)) ?? userInfo.init(name: "", phoneNumber: "")
        productDetailDto = (try? values.decode(productInfo.self, forKey: .productDetailDto)) ?? productInfo.init(hitCount: 1, id: 1, name: "", description: "", price: 1, useStatus: "", productGrade: "", salesStatus: "")
        
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
