//
//  MyProduct.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/17.
//

import Foundation

class MyProduct: NSObject {
    var image: String = ""
    var name: String = ""
    var price: Int = 0
    var like: Int = 0
    var grade: String = ""
    var status : String = ""
    init(image: String, name: String, price: Int, like: Int, grade: String, status : String) {
        self.image = image
        self.name = name
        self.price = price
        self.like = like
        self.grade = grade
        self.status = status
    }
}

class Model: NSObject {
    func getProducts(subURL: String) -> [MyProduct] {
        var products = [MyProduct]()
        let task = URLSession.shared.dataTask(with: URL(string: NetworkController.baseURL + subURL)!) { (data, response, error) in
            print("연결!")
            if let dataJson = data {
                print(dataJson)
                do {
                    if let json = try JSONSerialization.jsonObject(with: dataJson, options: .allowFragments) as? [String: AnyObject]
                    {
                        
                        if let temp = json["data"] as? NSArray{
                            print(temp)
                                
                                for i in temp {
                                    var image: String?
                                    var name: String?
                                    var price: Int?
                                    var like: Int?
                                    var grade: String?
                                    var status : String?
                                    
                                    if let temp = i as? NSDictionary {
                                        
                                        image = temp["image"] as! String
                                        name = temp["name"] as! String
                                        price = temp["totalPrice"] as! Int
                                        like = temp["like"] as! Int
                                        grade = temp["grade"] as! String
                                        status = temp["status"] as! String
                                        
                                    }
                                    products.append(MyProduct(image: image!, name: name!, price: price!, like: like!, grade: grade!, status: status!))
                                }
                            }
                        }
                    }
                catch {
                    print("JSON 파상 에러")
                    
                }
            }
        }
        task.resume()
        
        return products
    }
}
