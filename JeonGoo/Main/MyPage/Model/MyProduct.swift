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
        products.append(MyProduct(image: "http://movie.phinf.naver.net/20171201_181/1512109983114kcQVl_JPEG/movie_image.jpg?type=m99_141_2", name: "macbookPro", price: 3000000, like: 32, grade: "A등급", status: "검수중"))
        products.append(MyProduct(image: "http://movie2.phinf.naver.net/20170925_296/150631600340898aUX_JPEG/movie_image.jpg?type=m99_141_2", name: "macbookAir", price: 1890000, like: 21, grade: "B등급", status: "판매중"))
        products.append(MyProduct(image: "http://movie2.phinf.naver.net/20170928_85/1506564710105ua5fS_PNG/movie_image.jpg?type=m99_141_2", name: "airpod", price: 260000, like: 14, grade: "A등급", status: "검수중"))

        
        return products
    }
}
