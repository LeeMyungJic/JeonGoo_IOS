//
//  JoinViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/15.
//

import UIKit

class JoinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func join(_ sender: Any) {
            let msg = UIAlertController(title: "가입완료", message: "회원가입을 완료하였습니다", preferredStyle: .alert)
            
            let YES = UIAlertAction(title: "확인", style: .default, handler: { (action) -> Void in
               
                self.YesClick()
            })
            msg.addAction(YES)
            self.present(msg, animated: true, completion: nil)
        
    }
    
    func YesClick() {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
