//
//  JoinViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/15.
//

import UIKit
import Alamofire
import SwiftyJSON
import Moya


class JoinViewController: UIViewController {
    
    // MARK: --
    @IBOutlet weak var idStr: UITextField!
    @IBOutlet weak var passStr: UITextField!
    @IBOutlet weak var passChkStr: UITextField!
    @IBOutlet weak var nameStr: UITextField!
    @IBOutlet weak var numberStr: UITextField!
    @IBOutlet weak var completeBtn: CustomButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var manButton: RadioButton!
    @IBOutlet weak var womanButton: RadioButton!
    @IBOutlet weak var addressStr: UITextField!
    @IBOutlet weak var detailAddressStr: UITextField!
    
    var gender = "nil"
    var userProvider = MoyaProvider<UserService>()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        womanButton?.alternateButton = [manButton!]
        manButton?.alternateButton = [womanButton!]
        setEnabledButton(completeBtn)
    }
    
    // MARK: --
    @IBAction func join(_ sender: Any) {
        var msgalert = UIAlertController()
        
        let YES = UIAlertAction(title: "확인", style: .default, handler: { (action) -> Void in
            self.navigationController?.popToRootViewController(animated: true)
        })
        
        if passStr.text == passChkStr.text {
            if manButton.isSelected {
                gender = "MALE"
            }
            else {
                gender = "FEMALE"
            }
            userProvider.request(.signup(email: self.idStr.text ?? "", password: self.passStr.text ?? "", name: self.nameStr.text ?? "", number: self.numberStr.text ?? "", gender: self.gender, address: self.addressStr.text ?? "", detailAddress: self.detailAddressStr.text ?? "")) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    do {
                        if let json = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String: AnyObject]
                        {
                            if json["statusCode"] as? Int == 200 || json["statusCode"] as? Int == 201{
                                msgalert = UIAlertController(title: "가입완료", message: "회원가입을 완료하였습니다", preferredStyle: .alert)
                                msgalert.addAction(YES)
                                self.present(msgalert, animated: true)
                            }
                            else {
                                msgalert = UIAlertController(title: "가입실패", message: "서버가 불안정합니다. 잠시 후에 다시 시도하세요", preferredStyle: .alert)
                                msgalert.addAction(UIAlertAction(title: "확인", style: .default))
                                self.present(msgalert, animated: true, completion: nil)
                            }
                        }
                    } catch {
                    }
                case .failure:
                    let msg = UIAlertController(title: "가입실패", message: "네트워크 상태를 확인하세요", preferredStyle: .alert)
                    
                    let YES = UIAlertAction(title: "확인", style: .default)
                    msg.addAction(YES)
                    self.present(msg, animated: true, completion: nil)
                }
            }
        }
        else {
            let msg = UIAlertController(title: "가입실패", message: "비밀번호가 일치하지 않습니다", preferredStyle: .alert)
            
            let YES = UIAlertAction(title: "확인", style: .default)
            msg.addAction(YES)
            self.present(msg, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func tappedSearchBtn(_ sender: Any) {
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK d05457ec212e64c5f266ca54ee2728db"
        ]
        
        let parameters: [String: Any] = [
            "query": addressStr.text!,
            "page": 1,
            "size": 15
        ]
        
        AF.request("https://dapi.kakao.com/v2/local/search/address.json", method: .get,
                   parameters: parameters, headers: headers)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    print("통신 성공 !!")
                    
                    print(response.result)
                    print("total_count : \(JSON(value)["meta"]["total_count"])")
                    print("is_end : \(JSON(value)["meta"]["is_end"])")
                    print("documents : \(JSON(value)["documents"])")
                    
                    
                    if let detailsPlace = JSON(value)["documents"].array{
                        for item in detailsPlace{
                            let placeName = item["address_name"].string ?? ""
                            self.addressStr.text = placeName
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    // MARK: --
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
        if passChkStr.text != "" && passStr.text != "" && idStr.text != "" && nameStr.text != "" && numberStr.text != "" && addressStr.text != "" && detailAddressStr.text != ""{
            self.completeBtn.isEnabled = true
            self.completeBtn.backgroundColor = #colorLiteral(red: 1, green: 0.674518168, blue: 0, alpha: 1)
            self.errorLabel.text = ""
        }
        else {
            self.completeBtn.isEnabled = false
            self.completeBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            self.errorLabel.text = "모든 항목을 입력해 주세요!"
        }
    }
    
    
    func YesClick(code: Int) {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
}

