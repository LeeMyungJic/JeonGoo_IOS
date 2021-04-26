//
//  ViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit

import Moya
import RxSwift
import RxCocoa
import SwiftKeychainWrapper
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UITextField!
    @IBOutlet weak var passLabel: UITextField!
    @IBOutlet weak var loginBtn: CustomButton!
    
    private let userProvider = MoyaProvider<UserService>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func Login(_ sender: Any) {
        
        userProvider.request(.signin(email: self.idLabel.text ?? "", password: self.passLabel.text ?? "")) { [weak self] result in
            guard let self = self else { return }
            
            var code = 0
            
            switch result {
              case .success(let response):
                do {
                    code = response.statusCode
                    
                } catch {
                }
              case .failure:
                print("error")
              }
            if code == 200 {
                self.nextVC()
            }
            
            
        }
//        let id = self.idLabel.text
//        let pass = self.passLabel.text
//
//        if id == "" || pass == "" {
//        }
//        else {
//            let param: [String:Any] = [
//                "email": id,
//                "password": pass
//            ]
//
//            Post(
//                param: param, subURL: "/users/signin", success: {
//                    self.nextVC()
//                }, fail: { msg in
//                })
//        }
    }
    
    func nextVC() {
        let storyboard = UIStoryboard.init(name: "Pages", bundle: nil)
        
        let popUp = storyboard.instantiateViewController(identifier: "Pages")
        popUp.modalPresentationStyle = .overCurrentContext
        popUp.modalTransitionStyle = .crossDissolve
        
        self.present(popUp, animated: true, completion: nil)
    }
}

