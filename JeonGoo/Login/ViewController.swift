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
            
            var msgalert = UIAlertController()
            
            switch result {
              case .success(let response):
                do {
                    if response.statusCode == 200 {
                        if let json = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String: AnyObject]
                        {
                            if json["statusCode"] as? Int == 200 {
                                self.nextVC()
                            }
                            else {
                                msgalert = UIAlertController(title: "로그인 실패", message: "아이디 혹은 비밀번호를 확인하세요", preferredStyle: .alert)
                                msgalert.addAction(UIAlertAction(title: "확인", style: .default))
                                self.present(msgalert, animated: true, completion: nil)
                            }
                        }
                    }
                    
                } catch {
                }
              case .failure:
                msgalert = UIAlertController(title: "서버연결 실패", message: "네트워크 상태를 확인하세요", preferredStyle: .alert)
                msgalert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(msgalert, animated: true, completion: nil)
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

