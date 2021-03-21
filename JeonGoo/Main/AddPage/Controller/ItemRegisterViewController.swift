//
//  ItemRegisterViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit

class ItemRegisterViewController: UIViewController, DeliveryDataProtocol, UINavigationControllerDelegate {
    func deliveryData(_ data: String) {
        print("데이터 가져옴")
        guard let second = self.tabBarController?.viewControllers?[0] else {
            return
        }

        self.tabBarController?.selectedViewController = second
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        

        guard let vc = self.storyboard?.instantiateViewController(identifier: "adViewController") as? adViewController else {
            return
        }
        // second 뷰의 대리자는 나(first 뷰)야 !
        vc.delegateDate = self
        self.present(vc, animated: true, completion: nil)
        
//        present(vc, animated: true) {
//            vc.changeView = {
//                print("클로저 실행")
                
//            }
//        }
    }
    
    func YesClick()
    {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
