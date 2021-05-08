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
    var getProduct = productData(userShowResponse: productData.userInfo(name: "Null", phoneNumber: "Null"), productDetailDto: productData.productInfo.init(id: -1, name: "Null", description: "Null", price: -1, useStatus: "Null", productGrade: "Null", salesStatus: "Null"))
    
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
    
    
    
    func requestProductsByUserId(completion: @escaping (([productData], Error?) -> Void)) {
        provider.request(.findByUserId) { result in
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
    
    func requestProductRegister(description: String, name: String, price: String, serialNumber: String, useStatus: String, completion: @escaping ((Post?, Error?) -> Void)) {
        provider.request(.productRegistration(description: description, name: name, price: price, serialNumber: serialNumber, useStatus: useStatus)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let post = try decoder.decode(Post.self, from: response.data)
                    completion(post, nil)
                }
                catch (let error) {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func requestRemoveProduct(completion: @escaping((Get?, Error?) -> Void)) {
        provider.request(.removeProduct) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let get = try decoder.decode(Get.self, from: response.data)
                    completion(get, nil)
                }
                catch (let error) {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func requestPurchaseProduct(completion: @escaping((Post?, Error?) -> Void)) {
        provider.request(.purchaseProduct) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let post = try decoder.decode(Post.self, from: response.data)
                    completion(post, nil)
                }
                catch (let error) {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func requestFindPurchasedProductByUserId(completion: @escaping(([productData], Error?) -> Void)) {
        provider.request(.findPurchaseProductByUserId) { result in
            switch result {
            case .success(let response):
                do {
                    let result = try! JSONDecoder().decode(ResponseArrayType<productData>.self, from: response.data)
                    //self.getProducts = result.data!
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
    
    func requestFindSellProductByUserId(completion: @escaping(([productData], Error?) -> Void)) {
        provider.request(.findSellProductByUserId) { result in
            switch result {
            case .success(let response):
                do {
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
}
