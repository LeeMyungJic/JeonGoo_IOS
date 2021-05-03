//
//  ProductViewModel.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/04/29.
//

import Foundation

class ProductViewModel {
    fileprivate let service = ProductDataService()
    
    
    var Products = [productData]()
    var Product: productData?
    var message: String?
    
    func findAll(completion: @escaping ((ViewModelState) -> Void)) {
        service.requestProducts { (productData, error) in
            if let error = error {
                self.message = error.localizedDescription
                completion(.failure)
                return
            }
            self.Products = productData
            completion(.success)
        }
    }
    
    func findByUserId(id: Int, completion: @escaping ((ViewModelState) -> Void)) {
        service.requestProductsByUserId(id: id) { (productData, error) in
            if let error = error {
                self.message = error.localizedDescription
                completion(.failure)
                return
            }
            self.Products = productData
            completion(.success)
        }
    }
    
    func findByProductId(id: Int, completion: @escaping ((ViewModelState) -> Void)) {
        service.requestProductsByProductId(id: id) { (productData, error) in
            if let error = error {
                self.message = error.localizedDescription
                completion(.failure)
                return
            }
            self.Product = productData
            completion(.success)
        }
    }
}
