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
        vc.delegateDate = self
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func YesClick()
    {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
