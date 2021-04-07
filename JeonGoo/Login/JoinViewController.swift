//
//  JoinViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/15.
//

import UIKit

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
    
// MARK: --
    @IBAction func join(_ sender: Any) {
        if passStr.text == passChkStr.text {
            let msg = UIAlertController(title: "가입완료", message: "회원가입을 완료하였습니다", preferredStyle: .alert)
            
            let YES = UIAlertAction(title: "확인", style: .default, handler: { (action) -> Void in
                
                self.YesClick(code:0)
            })
            msg.addAction(YES)
            self.present(msg, animated: true, completion: nil)
        }
        else {
            let msg = UIAlertController(title: "에러", message: "비밀번호가 일치하지 않습니다!", preferredStyle: .alert)
            
            let YES = UIAlertAction(title: "확인", style: .default, handler: { (action) -> Void in
                
                self.YesClick(code:1)
            })
            msg.addAction(YES)
            self.present(msg, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
        if passChkStr.text != "" && passStr.text != "" && idStr.text != "" && nameStr.text != "" && numberStr.text != ""{
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
        if code == 0 {
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        womanButton?.alternateButton = [manButton!]
        manButton?.alternateButton = [womanButton!]
        setEnabledButton(completeBtn)
    }
}
