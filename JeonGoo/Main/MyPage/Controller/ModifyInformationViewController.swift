//
//  ModifyInformationViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/05/05.
//

import UIKit

class ModifyInformationViewController: UIViewController {

    @IBOutlet weak var emailStr: UITextField!
    @IBOutlet weak var passStr: UITextField!
    @IBOutlet weak var passChkStr: UITextField!
    @IBOutlet weak var nameStr: UITextField!
    @IBOutlet weak var numberStr: UITextField!
    @IBOutlet weak var addressStr: UITextField!
    @IBOutlet weak var addressDetailStr: UITextField!
    
    @IBOutlet weak var manBtn: RadioButton!
    @IBOutlet weak var womanBtn: RadioButton!
    
    var userViewModel = UserViewModel()
    var gender = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userViewModel.getUserInfo(userId: MyPageViewController.userId!) { state in
            self.emailStr.text = self.userViewModel.user?.email
            self.passStr.text = self.userViewModel.user?.password
            self.passChkStr.text = self.userViewModel.user?.password
            self.nameStr.text = self.userViewModel.user?.name
            self.numberStr.text = self.userViewModel.user?.phoneNumber
            self.addressStr.text = self.userViewModel.user?.addressDto.city
            self.addressDetailStr.text = self.userViewModel.user?.addressDto.detailed
            self.gender = self.userViewModel.user!.gender
            
        }
        
        womanBtn?.alternateButton = [manBtn!]
        manBtn?.alternateButton = [womanBtn!]
        
        if gender == "MALE" {
            manBtn.isSelected = true
        }
        else {
            womanBtn.isSelected = true
        }

        // Do any additional setup after loading the view.
    }
    
    fileprivate func showPostErrorAlert() {
        showAlertController(withTitle: "정보 수정 실패", message: "서버가 불안정합니다.", completion: nil)
    }
    fileprivate func showDuplicatedErrorAlert() {
        showAlertController(withTitle: "정보 수정 실패", message: "이미 아이디가 존재합니다.", completion: nil)
    }
    fileprivate func showSuccessAlert() {
        let msgalert = UIAlertController(title: "정보 수정 성공", message: "회원 정보를 수정하였습니다", preferredStyle: .alert)
        
        let YES = UIAlertAction(title: "확인", style: .default, handler: { (action) -> Void in
            self.navigationController?.popToRootViewController(animated: true)
        })
        msgalert.addAction(YES)
        present(msgalert, animated: true, completion: nil)
    }
    fileprivate func showIncorrectErrorAlert() {
        showAlertController(withTitle: "정보 수정 실패", message: "비밀번호가 일치하지 않습니다.", completion: nil)
    }
    
    @IBAction func didTapCompletion(_ sender: Any) {
        if passStr.text == passChkStr.text {
            if manBtn.isSelected {
                gender = "MALE"
            }
            else {
                gender = "FEMALE"
            }
            userViewModel.signUpPost(email: self.emailStr.text!, password: self.passStr.text!, name: self.nameStr.text!, number: self.numberStr.text!, gender: self.gender, address: self.addressStr.text!, detailAddress: self.addressDetailStr.text!) { state in
                switch state {
                case .success: self.showSuccessAlert()
                case .failure: if "\(MyPageViewController.userId!)" != self.emailStr.text {
                    self.showDuplicatedErrorAlert()
                }
                else {
                    self.showSuccessAlert()
                }
                case .serverError: self.showPostErrorAlert()
                }
                
            }
        }
        else {
            self.showIncorrectErrorAlert()
        }
    }
    @IBAction func didTapCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
