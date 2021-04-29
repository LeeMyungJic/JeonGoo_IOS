//
//  PDataService.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/04/29.
//

import Foundation
import Moya

class ProductDataService {
    var getProducts = [getProduct]()
    fileprivate let provider = MoyaProvider<ProductService>(endpointClosure: { (target: ProductService) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            let httpHeaderFields = ["Content-Type" : "application/json"]
            return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
        }
    })
    
    func requestProducts(completion: @escaping (([getProduct], Error?) -> Void)) {
        provider.request(.findAll) { result in
            switch result {
            case .success(let response):
                do {
                    self.getProducts = [getProduct]()
                    if let json = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String: AnyObject]
                    {
                        if let temp = json["data"] as? NSArray {
                            
                            for i in temp {
                                var id = 0
                                var name = ""
                                var price = 0
                                var useStatus = ""
                                var productGrade = ""
                                if let temp = i as? NSDictionary {
                                    id = temp["id"] as! Int
                                    name = temp["name"] as! String
                                    let priceTemp = temp["price"] as! [String:Any]
                                    price = priceTemp["value"] as! Int
                                    useStatus = temp["useStatus"] as! String
                                    productGrade = temp["productGrade"] as! String
                                
                                }
                                self.getProducts.append(getProduct(id: id, name: name, price: price, productGrade: .HIGH, useStatus: .USED))
                            }
                        }
                    }
                
                    completion(self.getProducts, nil)
                }
            catch (let error) {
                    completion([], error)
                }
            case .failure(let error):
                completion([], error)
            }
        }
    }
    
    func requestProductsByUserId(id: Int, completion: @escaping (([getProduct], Error?) -> Void)) {
        provider.request(.findByUserId(UserId: id)) { result in
            switch result {
            case .success(let response):
                do {
                    self.getProducts = [getProduct]()
                    if let json = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String: AnyObject]
                    {
                        if let temp = json["data"] as? NSArray {
                            
                            for i in temp {
                                var id = 0
                                var name = ""
                                var price = 0
                                var useStatus = ""
                                var productGrade = ""
                                if let temp = i as? NSDictionary {
                                    id = temp["id"] as! Int
                                    name = temp["name"] as! String
                                    let priceTemp = temp["price"] as! [String:Any]
                                    price = priceTemp["value"] as! Int
                                    useStatus = temp["useStatus"] as! String
                                    productGrade = temp["productGrade"] as! String
                                
                                }
                                self.getProducts.append(getProduct(id: id, name: name, price: price, productGrade: .HIGH, useStatus: .USED))
                            }
                        }
                    }
                
                    completion(self.getProducts, nil)
                }
            catch (let error) {
                    completion([], error)
                }
            case .failure(let error):
                completion([], error)
            }
        }
    }
}
