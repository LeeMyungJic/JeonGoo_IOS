//
//  ViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit

import Moya

class ViewController: UIViewController {
    
    @IBOutlet weak var idLabel: SetTextUI!
    @IBOutlet weak var passLabel: SetTextUI!
    @IBOutlet weak var loginBtn: CustomButton!
    
    fileprivate let userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func Login(_ sender: Any) {
        userViewModel.signInPost(email: self.idLabel.text!, pass: passLabel.text!) { state in
            print("state : \(state)")
            switch state {
            case .success: self.nextVC()
            case .failure: self.showPostErrorAlert()
            case .serverError: self.showIncoreectErrorAlert()
            }
            
        }
    }
    
    func nextVC() {
        let storyboard = UIStoryboard.init(name: "Pages", bundle: nil)
        
        let popUp = storyboard.instantiateViewController(identifier: "Pages")
        popUp.modalPresentationStyle = .overCurrentContext
        popUp.modalTransitionStyle = .crossDissolve
        
        self.present(popUp, animated: true, completion: nil)
    }
    
    fileprivate func showPostErrorAlert() {
        showAlertController(withTitle: "로그인 실패", message: "서버가 불안정합니다. 잠시후에 시도해주세요", completion: nil)
    }
    fileprivate func showIncoreectErrorAlert() {
        showAlertController(withTitle: "로그인 실패", message: "아이디와 패스워드를 확인하세요", completion: nil)
    }
}

