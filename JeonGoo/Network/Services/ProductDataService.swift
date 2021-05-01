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
    var getProductData: getProduct = getProduct(id: -1, name: "NULL", price: -1, productGrade: .HIGH, useStatus: .USED, productDescription: "NULL")
    
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
                                let getItem = i as! [String:Any]
                                let getProductDetailDto = getItem["productDetailDto"] as! [String:Any]
                                let id = getProductDetailDto["id"] as! Int
                                let name = getProductDetailDto["name"] as! String
                                let price = getProductDetailDto["price"] as! Int
                                let useStatus = getProductDetailDto["useStatus"] as! String
                                let productGrade = getProductDetailDto["productGrade"] as! String
                                let productDescription = getProductDetailDto["description"] as! String
                                
                                self.getProducts.append(getProduct(id: id, name: name, price: price, productGrade: .HIGH, useStatus: .USED, productDescription: productDescription))
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
                                let getItem = i as! [String:Any]
                                let getProductDetailDto = getItem["productDetailDto"] as! [String:Any]
                                let id = getProductDetailDto["id"] as! Int
                                let name = getProductDetailDto["name"] as! String
                                let price = getProductDetailDto["price"] as! Int
                                let useStatus = getProductDetailDto["useStatus"] as! String
                                let productGrade = getProductDetailDto["productGrade"] as! String
                                let productDescription = getProductDetailDto["productDescription"] as? String ?? "NULL"
                                
                                self.getProducts.append(getProduct(id: id, name: name, price: price, productGrade: .HIGH, useStatus: .USED, productDescription: productDescription))
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
    
    func requestProductsByProductId(id: Int, completion: @escaping ((getProduct, Error?) -> Void)) {
        provider.request(.findById(productId: id)) { result in
            
            
            switch result {
            case .success(let response):
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String: AnyObject]
                    {
                        if let temp = json["data"] as? [String:Any] {
                            let getProductDetailDto = temp["productDetailDto"] as! [String:Any]
                            self.getProductData.id = getProductDetailDto["id"] as! Int
                            self.getProductData.name = getProductDetailDto["name"] as! String
                            self.getProductData.price = getProductDetailDto["price"] as! Int
                            self.getProductData.productDescription = getProductDetailDto["description"] as! String
//                            self.getProductData.useStatus = Status(rawValue: getProductDetailDto["useStatus"] as! String)!
//                            self.getProductData.productGrade = Grade(rawValue: getProductDetailDto["productGrade"] as! String)!
                            
                        }
                    }
                    
                    completion(self.getProductData, nil)
                }
                catch (let error) {
                    completion(self.getProductData, error)
                }
            case .failure(let error):
                completion(self.getProductData, error)
            }
        }
    }
}
