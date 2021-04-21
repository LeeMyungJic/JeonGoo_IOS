//
//  Get.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/17.
//

import Foundation

func Get(subURL: String){
    let task = URLSession.shared.dataTask(with: URL(string: NetworkController.baseURL + subURL)!) { (data, response, error) in
        print("연결!")
        if let dataJson = data {
            print(dataJson)
            do {
                if let json = try JSONSerialization.jsonObject(with: dataJson, options: .allowFragments) as? [String: AnyObject]
                {
                    
                    }
                }
            catch {
                print("JSON 파상 에러")
                
            }
        }
    }
    task.resume()
}
