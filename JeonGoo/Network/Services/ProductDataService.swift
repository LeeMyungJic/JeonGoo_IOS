//
//  PDataService.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/04/29.
//

import Foundation
import Moya

class ProductDataService {
    var getProducts = [productData]()
    var getProduct = productData(userShowResponse: productData.userInfo(name: "Null", phoneNumber: "Null"), productDetailDto: productData.productInfo(id: -1, name: "Null", description: "Null", price: -1, useStatus: "Null", productGrade: "Null", salesStatus: "Null"))
    
    fileprivate let provider = MoyaProvider<ProductService>(endpointClosure: { (target: ProductService) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            let httpHeaderFields = ["Content-Type" : "application/json"]
            return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
        }
    })
    
    func requestProducts(completion: @escaping (([productData], Error?) -> Void)) {
        provider.request(.findAll) { result in
            switch result {
            case .success(let response):
                do {
                    //self.getProducts = [productData]()
                    
                    let result = try! JSONDecoder().decode(ResponseArrayType<productData>.self, from: response.data)
                    self.getProducts = result.data!
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
    
    
    
    func requestProductsByUserId(id: Int, completion: @escaping (([productData], Error?) -> Void)) {
        provider.request(.findByUserId(UserId: id)) { result in
            switch result {
            case .success(let response):
                do {
                    self.getProducts = [productData]()
                    let result = try! JSONDecoder().decode(ResponseArrayType<productData>.self, from: response.data)
                    self.getProducts = result.data!
                    
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
    
    func requestProductsByProductId(id: Int, completion: @escaping ((productData, Error?) -> Void)) {
        provider.request(.findById(productId: id)) { result in
            
            
            switch result {
            case .success(let response):
                do {
                    let result = try! JSONDecoder().decode(ResponseType<productData>.self, from: response.data)
                    self.getProduct = result.data!
                    completion(self.getProduct, nil)
                }
                catch (let error) {
                    completion(self.getProduct, error)
                }
            case .failure(let error):
                completion(self.getProduct, error)
            }
        }
    }
}
